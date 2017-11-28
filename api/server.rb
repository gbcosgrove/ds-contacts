require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'
require 'shotgun'

Mongoid.load! 'mongoid.config'




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

