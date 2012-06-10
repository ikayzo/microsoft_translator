require 'json'
module MicrosoftTranslator
  class AzureAuthentication
    AUTH_URL = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
    API_SCOPE = 'http://api.microsofttranslator.com'
    GRANT_TYPE = 'client_credentials'

    attr_reader :token
    attr_reader :token_expires_at

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
      renew_token
    end

    def current_token
      if @token_expires_at < Time.now
        renew_token
      end
      @token
    end


    def renew_token
       auth_response = RestClient.post(AUTH_URL, auth_params)
       parsed_json = JSON.parse(auth_response.body)
       @token_expires_at = Time.now + parsed_json['expires_in'].to_i
       @token = parsed_json['access_token']
    end

    private

    def auth_params
      {
      "client_id" => @client_id,
      "client_secret" => URI.encode(@client_secret),
      "scope" => URI.encode(API_SCOPE),
      "grant_type" => GRANT_TYPE
      }

    end
  end
end
