require 'microsoft_translator/version'
require 'uri'
require 'rest-client'

module MicrosoftTranslator
  autoload :Client, 'microsoft_translator/client'
  autoload :AzureAuthentication, 'microsoft_translator/azure_authentication'
end
