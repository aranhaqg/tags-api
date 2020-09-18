module Mutations
  class CreateTicket < BaseMutation
    argument :user_id, Integer, required: true
    argument :title, String, required: true
    argument :tags, [String], required: false

    field :ticket, Types::TicketType, null: false

    def resolve(user_id: nil, title: nil, tags: nil)
      ticket = Ticket.create!(
        user_id: user_id,
        title: title,
        tags: tags,
      )

      { ticket: ticket }
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end
  end
end