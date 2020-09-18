require 'net/http'

class Ticket < ApplicationRecord
	validates :user_id, :title,  presence: true 
	validates :tags, length: { maximum: 5 }

	before_save :normalize_tags
  after_save :increment_tags, :trigger_webhook

	private 

  def normalize_tags
    return if tags.blank?

		normalized_tags =[]
		tags.each do |tag_name|
			normalized_tags << tag_name.downcase
		end

		self.tags = normalized_tags
	end

  def increment_tags
    return if tags.blank?

		tags.each do |tag_name|
			tag = Tag.where(name: tag_name).first
			tag = Tag.new(name: tag_name, count: 0) unless tag
			tag.count+=1
			tag.save
		end
  end
  
  def trigger_webhook
    return if tags.blank?
    
    tag_with_highest_count = Tag.with_highest_count.name || nil
    payload = { tag: tag_with_highest_count }
    response = request('https://webhook.site/', payload ) if tag_with_highest_count
  end

  def request(endpoint, payload)
    uri = URI.parse(endpoint)
    request = Net::HTTP::Get.new(uri.request_uri)
    request['Content-Type'] = 'application/json'
    request.body = payload.to_json
  
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    
    http.request(request)
  end
end
