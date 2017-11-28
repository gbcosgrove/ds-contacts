
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

