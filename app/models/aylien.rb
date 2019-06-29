class Aylien
  require 'aylien_text_api'


  def self.check(text)
    credentials = YAML.load(File.read("#{Rails.root}/config/aylien.yml"))

    textapi = AylienTextApi::Client.new(app_id: credentials["appId"], app_key: credentials["apiKey"])

    map = {"positive"=>1,"neutral"=>2,"negative"=>3}

    response = textapi.sentiment text: text

    return map[response[:polarity]]

  end
end