require 'test_helper'

class TicketTest < ActiveSupport::TestCase
	test 'should not save a ticket without user_id' do
		invalid_ticket = tickets(:one)
		invalid_ticket.user_id = nil
  		assert_not invalid_ticket.save, 'Saved the ticket without a user_id'
	end
	
	test 'should not save a ticket without title' do
		invalid_ticket = tickets(:one)
		invalid_ticket.title = nil
  		assert_not invalid_ticket.save, 'Saved the ticket without a title'
	end

	test 'should not save a ticket with 6 tags' do
		invalid_ticket = tickets(:one)
		invalid_ticket.tags = [1,2,3,4,5,6]
		assert_not invalid_ticket.save, 'Saved the ticket with six tags'
	end 

	test 'should normalize all ticket tags' do
		ticket = tickets(:one)
		ticket.tags = ['PENding', 'sTARTEd']
		ticket.save
		ticket.reload
		assert_equal ['pending', 'started'], ticket.tags 
	end

	test 'should increment tags count after saving a valid ticket' do
		valid_ticket = Ticket.new(user_id: 1, title: 'New ticket', tags: ['brand new tag'])
		valid_ticket.save
		tag = Tag.where(name: 'brand new tag').first

		assert_equal tag.count, 1 
	end
end
