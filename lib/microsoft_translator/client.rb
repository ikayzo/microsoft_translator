module MicrosoftTranslator
  class Client

    def initialize(client_id, client_secret)
      @client_id = client_id
      raise "client_id must be a string" unless @client_id.is_a?(String)
      @client_secret = client_secret
      raise "client_secret must be a string" unless @client_secret.is_a?(String)

      @auth = MicrosoftTranslator::AzureAuthentication.new(client_id, client_secret)
    end
  end
end
