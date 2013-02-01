require 'rubygems'
require 'bundler/setup'

require 'microsoft_translator'
require 'timecop' 
require 'webmock/rspec' 

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  # some (optional) config here
end
