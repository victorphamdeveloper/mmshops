namespace :db do
  desc "TODO"
  task :create_products => :environment do
    i = 32
    while i <= 40
      i += 1
    	s = Seller.find(i)
    	10.times do |p|
    		name  = Faker::Name.name
    		s.products.create!(name: name, category_id: 10, price: 50, description: "test product", location: "Yangon")  
    	end
    end
  	
  end

end
