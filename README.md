# Tags API [![Build Status](https://travis-ci.com/aranhaqg/tags-api.svg?branch=master)](https://travis-ci.com/aranhaqg/tags-api)

Tags API is a Rails GraphQl API that accepts JSON payload that looks like:

```json
{
  "user_id" : 1234,
  "title" : "My title",
  "tags" : ["tag1", "tag2"]
}
```
And then try to create a Ticket with these attributes. If the ticket is valid, it triggers a webhook with a payload containing the the tag with the highest count. 

This app uses:

* Ruby version 2.7.1
* Rails 6.0.3
* PostgreSQL 12.4
* GraphQL 1.9.17

For more details check [Gemfile](Gemfile).

This app is published at Heroku and this repo has a webhook pointing to https://webhook.site.

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



