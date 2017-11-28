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

class ContactSerializer

  def initialize(contact)
    @contact = contact
  end

  def as_json(*)
    data = {
      id: @contact.id.to_s
      firstName: @contact.first_name,
      lastName: @contact.last_name,
      phone: @contact.phone,
      email: @contact.email
    }
    data[:errors] = @contacts.errors if @contacts.errors.any?
    data
  end
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

