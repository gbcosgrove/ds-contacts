require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'
require 'shotgun'

Mongoid.load! 'mongoid.config'


set :port, 3000

class Contact
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :phone, type: String
  field :email, type: String

  validates :first_name, presence: true
  validates :last_name, presence: true
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

