class Ticket < ApplicationRecord
	validates :user_id, :title,  presence: true 
	validates :tags, length: { maximum: 5 }

	before_save :normalize_tags
	after_save :increment_tags

	private 

	def normalize_tags
		normalized_tags =[]
		tags.each do |tag_name|
			normalized_tags << tag_name.downcase
		end

		self.tags = normalized_tags
	end

	def increment_tags
		tags.each do |tag_name|
			tag = Tag.where(name: tag_name).first
			tag = Tag.new(name: tag_name, count: 0) unless tag
			tag.count+=1
			tag.save
		end
	end
end
