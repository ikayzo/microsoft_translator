module MicrosoftTranslator
  class Client

    def initialize(client_id, client_secret)
      @client_id = client_id
      raise "client_id must be a string" unless @client_id.is_a?(String)
      @client_secret = client_secret
      raise "client_secret must be a string" unless @client_secret.is_a?(String)
      @auth = MicrosoftTranslator::AzureAuthentication.new(client_id, client_secret)
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

    def translate_array(array, from_lang, to_lang)
      raise "Array too large" if array.length > 2000 || array.join.length > 10_000
      begin
        response = RestClient.post(
          "http://api.microsofttranslator.com/V2/Http.svc/TranslateArray",
          translate_array_params(array, from_lang, to_lang),
          { :content_type => "text/xml",
            :Authorization => "Bearer #{@auth.current_token}" }
        )
        parse_translate_array(response)
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

    def translate_array_params(array, from_lang, to_lang)
      xml_body = "<TranslateArrayRequest><AppId /><From>" +
      from_lang + "</From><Texts>"
      array.each do |s|
        xml_body = xml_body + "<string xmlns=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\">" + s + "</string>"
      end
      xml_body = xml_body + "</Texts><To>" + to_lang + "</To></TranslateArrayRequest>"
    end

    def detect_params(text)
      hash = base_params
      hash.store(:params,{
        "text" => text
      })
      hash
    end

    def parse_translate_array(xml)
      xml_doc = Nokogiri::XML(xml)
      text_array = []
      xml_doc.css("TranslatedText").each do |t|
        text_array << t.text
      end
      text_array
    end

    def parse_xml(xml)
      xml_doc = Nokogiri::XML(xml)
      xml_doc.xpath("/").text
    end
  end
end
