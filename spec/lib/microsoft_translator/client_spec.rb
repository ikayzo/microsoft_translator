require "spec_helper"

describe MicrosoftTranslator::Client do
  describe "#initialize" do
    it "should build a new AzureAuthentication with the id and secret" do
      MicrosoftTranslator::AzureAuthentication.should_receive(:new).with('id','secret')
      translator = MicrosoftTranslator::Client.new('id', 'secret')
    end
  end

end
