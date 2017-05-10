module MicrosoftTranslator
  class AzureAuthentication
    AUTH_URL = 'https://api.cognitive.microsoft.com/sts/v1.0/issueToken'
    API_SCOPE = 'http://api.microsofttranslator.com'

    attr_reader :token
    attr_reader :token_expires_at

    def initialize(subscription_id)
      @subscription_id = subscription_id
      renew_token
    end

    def current_token
      if @token_expires_at < Time.now
        renew_token
      end
      @token
    end


    def renew_token
       auth_response = RestClient.post(AUTH_URL, "", auth_header).body
       @token_expires_at = Time.now + 10 * 60
       @token = auth_response
    end

    private

    def auth_header
      {
        :"Ocp-Apim-Subscription-Key"  => @subscription_id,
        :content_type => "application/json"
      }
    end
  end
end
