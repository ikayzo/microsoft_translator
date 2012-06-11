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
      response = RestClient.get(
        "http://api.microsofttranslator.com/V2/Http.svc/Translate",
        translate_params(text, from_lang, to_lang, content_type)
      )
      parse_xml(response.body)
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
      puts hash
      hash
    end

    def parse_xml(xml)
      xml_doc = Nokogiri::XML(xml)
      xml_doc.xpath("/").text
    end
  end
end
