namespace :db do
	task createCities: :environment do

		City.create!(name: "Yangon")
	    City.create!(name: "Mandalay")
	    City.create!(name: "Naypyidaw")
	    City.create!(name: "Mawlamyaing")
	    City.create!(name: "Bago")
	    City.create!(name: "Pathein")
	    City.create!(name: "Monywa")
	    City.create!(name: "Meiktila")
	    City.create!(name: "Sittwe")
	    City.create!(name: "Mergui")
	    City.create!(name: "Taunggyi")
	end
end
