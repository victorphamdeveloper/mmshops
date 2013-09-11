namespace :db do
  desc "TODO"
  task :create_products => :environment do
    i = 2
    while i <= 5
      i += 1
    	s = User.find(i)
    	10.times do |p|
    		name  = Faker::Name.name
    		s.products.create!(name: name, 
                          category_id: 10, 
                          price: 50, 
                          description: "test product",  
                          location: "Yangon",
                          ban: 0)  
    	end
    end
  	
  end

end
