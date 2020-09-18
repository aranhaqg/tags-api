class Tag < ApplicationRecord

  def self.with_highest_count
    Tag.all.order(:count).last
  end
end
