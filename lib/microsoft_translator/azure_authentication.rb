module MicrosoftTranslator
  class AzureAuthentication
    AUTH_URL = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
    API_SCOPE = 'http://api.microsofttranslator.com'
    GRANT_TYPE = 'client_credentials'

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def latest_token
      # check if current token is still good
      # get new_token if not
    end

    private

    def renew_token
       auth_response = RestClient.post(Entry.auth_request_body)
       parsed_json = JSON.parse(auth_response.body)
    end

    def auth_params
      {
      "client_id" => Entry.client_id,
      "client_secret" => URI.encode(Entry.client_secret),
      "scope" => URI.encode(Entry.api_scope),
      "grant_type" => Entry.grant_type
    }

    end
  end
end
