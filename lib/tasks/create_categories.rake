namespace :db do
  task :createCategories => :environment do
  	c1 = Category.create(name: "Man")
	c2 = Category.create(name: "Woman")
	Category.create(name: "Other")
	c = c1.children.create(name: "Shoes")
	c1.children.create(name: "Belt")
	c1.children.create(name: "Shirts")
	c2.children.create(name: "Perfume")
	c2.children.create(name: "Necklace")
	c2.children.create(name: "Earing")
	c.children.create(name: "Adidas")
	c.children.create(name: "Nike")
	c.children.create(name: "Puma")

  end

end
