require 'net/http'

class WebhookTrigger

  def initialize(tag_name)
    @tag_name = tag_name
  end
  
  def send_tag_with_highest_count
    payload = { tag: @tag_name }
    response = request(payload) if @tag_name
  end

  private

  def request(payload)
    uri = URI.parse('https://webhook.site/')
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = payload.to_json
  
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    
    http.request(request)
  end
end