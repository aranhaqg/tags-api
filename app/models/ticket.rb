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
    Tag.transaction do
      tags.each do |tag_name|
        tag = Tag.where(name: tag_name).first
        tag = Tag.new(name: tag_name, count: 0) unless tag
        tag.count+=1
        tag.save
      end
    end
  end
  
  def trigger_webhook
    return if tags.blank?
    tag_with_highest_count = Tag.with_highest_count&.name || nil

    WebhookTrigger.new(tag_with_highest_count).send_tag_with_highest_count
  end
end
