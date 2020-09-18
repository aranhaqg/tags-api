class AllTagsTest < ActionDispatch::IntegrationTest
  all_tags_query = 
    %(
      {
        allTags {
          name
          count
        }
      }    
    )

  expected_body = 
    {
      "data"=> {
        "allTags"=> [
          {
            "name"=> "pending",
            "count"=> 2
          },
          {
            "name"=> "done",
            "count"=> 1
          }
        ]
      }
    }
  
  	
  
  test 'list all tags' do
  post('/graphql', params: {
    query: all_tags_query
  })

  assert_equal 200, response.status
  assert_equal expected_body, JSON.parse(response.body)
  end
end