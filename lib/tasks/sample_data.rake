namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "admin",
                 email: "admin@mmshops.com",
                 password: "123456",
                 password_confirmation: "123456",
                 location: "Yangon",
                 role: 1
                 )
    30.times do |n|
      name  = Faker::Name.name
      email = "user-#{n+1}@mmshops.com"
      password  = "password"
      User.create!(name: name,
                  email: email,
                  password: password,
                  password_confirmation: password,
                  location: "Yangon"
                  )
    end 

  end
end