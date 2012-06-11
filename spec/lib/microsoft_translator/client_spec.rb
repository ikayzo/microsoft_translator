require "spec_helper"

describe MicrosoftTranslator::Client do
  describe "#initialize" do
    it "should build a new AzureAuthentication with the id and secret" do
      stub_auth_request
      MicrosoftTranslator::AzureAuthentication.should_receive(:new).with('id','secret')
      translator = MicrosoftTranslator::Client.new('id', 'secret')
    end
  end

  describe "#translate" do
    it "should send a request with the correct params" do
      pending "better way to test this"
      stub_auth_request
      translator = MicrosoftTranslator::Client.new('id', 'secret')
      spanish = "no corras muchacho"
      stub_translate_request("don't run boy")
      translator.translate(spanish,"es","en","text/html").should eq("don't run boy")
    end
  end
end
