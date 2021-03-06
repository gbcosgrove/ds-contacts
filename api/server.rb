require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'
require 'shotgun'

Mongoid.load! 'mongoid.config'


set :port, 3000

class Contact
  include Mongoid::Document

  field :firstName, type: String
  field :lastName, type: String
  field :phone, type: String
  field :email, type: String

  validates :firstName, presence: true
  validates :lastName, presence: true
end

class ContactSerializer

  def initialize(contact)
    @contact = contact
  end

  def as_json(*)
    data = {
      id: @contact.id.to_s,
      firstName: @contact.firstName,
      lastName: @contact.lastName,
      phone: @contact.phone,
      email: @contact.email
    }
    data[:errors] = @contact.errors if @contact.errors.any?
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

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end

    def json_params
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message:'Invalid JSON Request' }.to_json
      end
    end

    def contact
      @contact ||= Contact.where(id: params[:id]).first
    end

    def not_found!
      halt(404, { message: 'Contact Not Found' }.to_json) unless contact
    end

    def serialize(contact)
      ContactSerializer.new(contact).to_json
    end
  end

  get '/contacts' do
    contacts = Contact.all

    [:firstName, :lastName, :phone, :email].each do |filter|
      contacts = contacts.send(filter, params[filter]) if params[filter]
    end

    contacts.map { |contact| ContactSerializer.new(contact) }.to_json
  end

  get '/contacts/:id' do |id|
    not_found!
    serialize(contact)
  end

  post '/contacts' do
    contact = Contact.new(json_params)
    halt 422, serialize(contact) unless contact.save

    response.headers['Location'] = "#{base_url}/api/v1/contacts/#{contact.id}"
    status 201
  end

  patch '/contacts/:id' do |id|
    not_found!
    halt 422, serialize(contact) unless contact.update_attributes(json_params)
    serialize(contact)
  end

  delete '/contacts/:id' do |id|
    contact.destroy if contact
    status 204
  end

end

