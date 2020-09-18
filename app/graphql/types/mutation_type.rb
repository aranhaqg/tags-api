module Types
  class MutationType < Types::BaseObject
    field :create_ticket, mutation: Mutations::CreateTicket
  end
end
