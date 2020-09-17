class AddTagsToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :tags, :text, array: true, default: []
  end
end
