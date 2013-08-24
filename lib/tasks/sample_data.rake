namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "admin",
                 email: "admin@mmshops.com",
                 password: "123456",
                 password_confirmation: "123456",
                 role: 1)
    30.times do |n|
      name  = Faker::Name.name
      email = "buyer-#{n+1}@mmshops.com"
      password  = "password"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password,
                  role: 3)
    end 

    30.times do |n|
      name  = Faker::Name.name
      email = "seller-#{n+1}@mmshops.com"
      password  = "password"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password,
                  role: 2)
    end
  end
end