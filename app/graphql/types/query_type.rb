module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :all_tickets, [TicketType], null: false,
      description: "Show all tickets"
    
      def all_tickets
      Ticket.all
    end

    field :all_tags, [TagType], null: false,
      description: "Show all tickets"
    
      def all_tags
      Tag.all
    end
  end
end
