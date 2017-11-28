# API Instructions

The following instructions are for the Sinatra based ds-contacts API.  It is for demo purposes only.  

The Sinatra API server can be started by doing the following from the root directory:

`cd api && ruby server.rb`

## Routes

The base route is:

`/api/v1/`

The API has been namespaced as a best practice for versioning the API.  

**GET routes**

`/api/v1/contacts/:id` => Returns all contacts as JSON

`/api/v1/contacts/:id` => Returns a single contact as JSON

**POST route**

`/api/v1/contacts` with JSON in header 

CURL EXAMPLE:

`curl -i -X POST -H "Content-Type: application/json" -d'{"firstName":"Joe", "lastName":"Bloggs"}' http://localhost:3000/api/v1/contacts` 

**PATCH route**

`/api/v1/contacts/:id` with JSON in header 

CURL EXAMPLE:

`curl -i -X PATCH -H "Content-Type: application/json" -d'{"email":"person@testmail.com"}' http://localhost:3000/api/v1/contacts/5a1d78fb7566503a27a387bc`  

**DELETE route**

`/api/v1/contacts/:id`

`curl -X "DELETE" "http://localhost:3000/api/v1/contacts/5a1d78fb7566503a27a387c0" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{}'` 