Design a REST API that allows you to manage contacts.
Please follow REST conventions.
The API must run on port 3000, the base route would be /contacts
The API must support JSON formatted data.

A contact is a document that contains id, first_name, last_name, phone, and email.
First and last name can never be blank, phone and email are optional fields and may be blank or not provided at all.

The API must support CRUD operations for contacts, specifically:
Create a new contact
Update a contact's first_name, last_name, phone, and/or email.
List contacts
List a single contact
Delete/Remove a contact

Data may be persisted in any manner, but it is not required to persist after the service is stopped.

The service must be able to be run from the command line and a startup script and instructions should be provided.

Bonus points for including unit/spec tests for the API.
