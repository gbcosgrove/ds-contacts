
require './server'
require 'faker'

if Contact.all == nil || []
  Contact.create_indexes

  10.times do
    Contact.create({firstName: Faker::Name.first_name,
                    lastName: Faker::Name.last_name,
                    email: Faker::Internet.email,
                    phone: Faker::PhoneNumber.cell_phone})
  end
end

