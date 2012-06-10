def auth_params(id, secret)
  {
    "client_id" => id,
    "client_secret" => secret,
    "scope" => URI.encode(MicrosoftTranslator::AzureAuthentication::API_SCOPE),
    "grant_type" => MicrosoftTranslator::AzureAuthentication::GRANT_TYPE
  }
end
def stub_auth_request(returned_token=nil)
  response = stub("response", :body => {"access_token"=>"#{returned_token || 'stubbed_token'}", "token_type"=>"http://schemas.xmlsoap.org/ws/2009/11/swt-token-profile-1.0", "expires_in"=>"599", "scope"=>"http://api.microsofttranslator.com"}.to_json)

  RestClient.stub(:post).and_return(response)
end
