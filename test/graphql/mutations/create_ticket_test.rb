class CreateTicketTest < ActionDispatch::IntegrationTest
    new_ticket_mutation = 
      %(
        mutation {
			createTicket (input: {
			  userId: 1,
		      title: "HALP!",
			  tags: ["pending", "urgent"]
			}){
			  ticket{
				userId
				tags
				title
			  }
			}
		  }
		  
      )

    expected_body = 
		{
			"data"=>{
				"createTicket"=>{
					"ticket"=>{
						"userId"=>1, 
						"tags"=>["pending", "urgent"], 
						"title"=>"HALP!"
					}
				}
			}
		}	
    
    test 'create a new ticket with valid params' do
		post('/graphql', params: {
			query: new_ticket_mutation
		})

		assert_equal 200, response.status
		assert_equal expected_body, JSON.parse(response.body)
    end
end
