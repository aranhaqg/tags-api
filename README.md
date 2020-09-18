# Tags API [![Build Status](https://travis-ci.com/aranhaqg/tags-api.svg?branch=master)](https://travis-ci.com/aranhaqg/tags-api)

Tags API is a Rails GraphQl API that accepts JSON payload to the path '/graphql' that looks like:

```json
{
  "user_id" : 1234,
  "title" : "My title",
  "tags" : ["tag1", "tag2"]
}
```
When that happens, the app try to create a Ticket with these attributes. 
If the ticket is valid, the ticket s saved at the database and a callback triggers a webhook to https://webhook.site with a payload containing the the tag with the highest count. 

This app uses:

* Ruby version 2.7.1
* Rails 6.0.3
* PostgreSQL 12.4
* GraphQL 1.9.17

For more details check [Gemfile](Gemfile).

This app is published at Heroku and you can access the graphql interface here: https://secure-depths-05821.herokuapp.com/graphiql

## Entities
### Ticket

The [Ticket](/app/models/ticket.rb) entity it's composed of the following properties:

* user_id: Integer
* title: String
* tags: array of String

### Tag 
The [Tag](/app/models/tag.rb) entity it's composed of the following properties:

* name: String
* count: Integer

## Important
With GraphQL is not possible to change the status code when returning model validation errors. When a error occurs, GraphQl return status code 200 and a array with all errors. Exmaple of a returning error:

```json
{
  "data": {
    "createTicket": null
  },
  "errors": [
    {
      "message": "Invalid input: Title can't be blank",
      "locations": [
        {
          "line": 2,
          "column": 3
        }
      ],
      "path": [
        "createTicket"
      ]
    }
  ]
}
```
# How to test the API
The GraphQL interface have a docs session that list all possible queries and mutations. The link to this interface is https://secure-depths-05821.herokuapp.com/graphiql.

In this app you can: create tickets, list all tickets and list all tags.
Above we have examples of the respective mutation and queries:

```
mutation {
  createTicket (input: {
    userId: 2, 
    title: "Davi Aranha",
    tags: ["Pending"]
  }){
    ticket{
      id
      userId
      tags
      title
    }
  }
}

{
  allTickets {
    id
    userId
    title
    tags
  }
  allTags {
    id
    name
    count
  } 
}

```

If you don't wanna use graphql interface you can use the same payload and post it to https://secure-depths-05821.herokuapp.com/graphql endpoint.
