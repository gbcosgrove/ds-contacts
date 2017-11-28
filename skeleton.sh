#!/bin/bash

## Setup directory structure
mkdir api &&
cd api &&
touch server.rb Gemfile Gemfile.lock seeds.rb mongoid.config Procfile.dev &&

# Add Sinatra Server Requirements
echo "require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'
require 'shotgun'

Mongoid.load! 'mongoid.config'

" >> server.rb &&

## Add Required Gems
echo "source 'https://rubygems.org'
gem 'sinatra'
gem 'mongoid'  
gem 'sinatra-contrib'
gem 'foreman'
gem 'faker'
gem 'shotgun'
" >> Gemfile &&
echo "
development:
  clients:
    default:
      database: contacts_dev
      hosts:
        - localhost:27017
" >> mongoid.config &&

# Add DB Seed File Info (optional)
echo "
require './server'
require 'faker'

if Contact.all == nil || []
  Contact.create_indexes

  10.times do 
    Contact.create({first_name: Faker::Name.first_name, 
                    last_name: Faker::Name.last_name, 
                    email: Faker::Internet.email, 
                    phone: Faker::PhoneNumber.cell_phone})
  end
end
" >> seeds.rb &&
bundle install &&
echo "

class Contact
  include Mongoid::Document

  field :firstName, type: String
  field :lastName, type: String
  field :phone, type: String
  field :email, type: String

  validates :firstName, presence: true
  validates :lastName, presence: true
end

get '/' do
  'Welcome to the Contacts App'
end

namespace '/api/v1' do
  
  before do
    content_type 'application/json'
  end

  get 'contacts' do
  end
end
" >> server.rb &&
ruby seeds.rb &&
cd .. &&
# Add React Using Create React App or your own file
create-react-app client &&
cd client &&
yarn add reactstrap axios
