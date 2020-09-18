class AllTicketsTest < ActionDispatch::IntegrationTest
  all_tickets_query = 
    %(
      {
        allTickets {
          userId
          title
          tags
        }
      }    
    )

  expected_body = 
    {
      "data"=> {
        "allTickets"=> [
          {
            "userId"=> 1,
            "title"=> "John",
            "tags"=> ['pending', 'done']
          },
          {
            "userId"=> 2,
            "title"=> "Lucy",
            "tags"=> ['done']
          }
        ]
      }
    }
  
  	
  
  test 'list all tickets' do
  post('/graphql', params: {
    query: all_tickets_query
  })

  assert_equal 200, response.status
  assert_equal expected_body, JSON.parse(response.body)
  end
end