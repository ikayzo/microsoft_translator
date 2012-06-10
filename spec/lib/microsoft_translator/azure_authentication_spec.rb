require "spec_helper"

describe MicrosoftTranslator::AzureAuthentication do
  def auth_params(id, secret)
    {
      "client_id" => id,
      "client_secret" => secret,
      "scope" => URI.encode(MicrosoftTranslator::AzureAuthentication::API_SCOPE),
      "grant_type" => MicrosoftTranslator::AzureAuthentication::GRANT_TYPE
    }
  end
  def stub_auth_request 
    response = stub("response", :body => {"access_token"=>"stubbed_token", "token_type"=>"http://schemas.xmlsoap.org/ws/2009/11/swt-token-profile-1.0", "expires_in"=>"599", "scope"=>"http://api.microsofttranslator.com"}.to_json)

    RestClient.stub(:post).and_return(response)
  end

  after :all do
    Timecop.return
  end

  describe "#initialize" do
    before :each do
      stub_auth_request
    end
    it "should get auth token" do
      auth = MicrosoftTranslator::AzureAuthentication.new('id', 'secret')
      auth.token.should eq('stubbed_token')
    end
  end

  describe "#renew_token" do
    before :each do
      stub_auth_request
      @auth = MicrosoftTranslator::AzureAuthentication.new('id','secret')
    end

    it "should build send a request if to get a new token" do
      RestClient.should_receive(:post).with(MicrosoftTranslator::AzureAuthentication::AUTH_URL, auth_params('id', 'secret'))
      @auth.renew_token
    end

    it "should set the token" do
      @auth.renew_token
      @auth.token.should eq("stubbed_token")
    end

    it "should set token_expires_at" do
      Timecop.freeze
      @auth.renew_token
      @auth.token_expires_at.should eq(Time.now + 599)
    end
  end

end
