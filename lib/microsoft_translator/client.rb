module MicrosoftTranslator
  class Client

    def initialize(subscription_id)
      @subscription_id = subscription_id
      raise "subscription_id must be a string" unless @subscription_id.is_a?(String)
      @auth = MicrosoftTranslator::AzureAuthentication.new(subscription_id)
    end

    def translate(text, from_lang, to_lang, content_type)
      begin
        response = RestClient.get(
          "http://api.microsofttranslator.com/V2/Http.svc/Translate",
          translate_params(text, from_lang, to_lang, content_type)
        )
        parse_xml(response.body)
      rescue RestClient::BadRequest
        false
      end
    end

    def detect(text)
      begin
        response = RestClient.get(
          "http://api.microsofttranslator.com/V2/Http.svc/Detect",
          detect_params(text)
        )
        parse_xml(response.body)
      rescue RestClient::BadRequest
        false
      end
    end

    private

    def base_params
      {:Authorization => "Bearer #{@auth.current_token}"}
    end

    def translate_params(text, from_lang, to_lang, content_type)
      hash = base_params
      hash.store(:params,{
        "text" => text,
        "from" => from_lang,
        "to" => to_lang,
        "contentType" => content_type
      })
      hash
    end

    def detect_params(text)
      hash = base_params
      hash.store(:params,{
        "text" => text
      })
      hash
    end

    def parse_xml(xml)
      xml_doc = Nokogiri::XML(xml)
      xml_doc.xpath("/").text
    end
  end
end
