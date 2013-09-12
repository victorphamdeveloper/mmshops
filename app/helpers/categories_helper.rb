module CategoriesHelper
	def leaves
		results = Array.new
		Category.all.each do |c|
			if !c.has_children?
				results.push(c)
			end
		end
		results
	end

	def generate_child(c)
		tree = "<li><a href='/products?category_id=#{c.id}'>#{c.name}</a>"
	
		if c.has_children?
			tree += "<ul>"
			c.children.each do |child|
					tree += generate_child(child)
			end
			tree += "</ul>"
		end

		tree += "</li>"
		tree.html_safe

	end
end
