class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
