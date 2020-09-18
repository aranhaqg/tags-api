module Types
  class TicketType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null:false
    field :title, String, null: false
    field :tags, [String], null: true
  end
end
