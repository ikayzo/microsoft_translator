require 'microsoft_translator/version'
require 'uri'
require 'rest-client'

module MicrosoftTranslator
  API_SCOPE = 'http://api.microsofttranslator.com'
  GRANT_TYPE = 'client_credentials'

  class << self
    attr_accessor :client_id
    attr_accessor :client_secret

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end
  end
end
