require 'microsoft_translator/version'
require 'uri'
require 'json'
require 'rest-client'
require 'nokogiri'

module MicrosoftTranslator
  autoload :Client, 'microsoft_translator/client'
  autoload :AzureAuthentication, 'microsoft_translator/azure_authentication'
end
