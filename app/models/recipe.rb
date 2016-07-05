class Recipe < ActiveRecord::Base
	has_many :menus
	has_many :materials

	def self.make_recipe menu, recipe_arr, recipe_unit_arr
		recipe_arr.each do |material|
			recipe = Recipe.new
			recipe.menu_id        = menu.to_i
			recipe.material_id    = material
			recipe.material_unit  = recipe_unit_arr[recipe_arr.index(material)]
			recipe.save
		end
	end

	def self.update_recipe menu, recipe_arr, recipe_unit_arr
		recipe_arr.each do |material|
			recipe = Recipe.where('menu_id = ? AND material_id = ?', menu, material).take
			if recipe.nil?
				recipe = Recipe.new
				recipe.menu_id        = menu.to_i
				recipe.material_id    = material
				recipe.material_unit  = recipe_unit_arr[recipe_arr.index(material)]
				recipe.save
			else
				recipe.material_unit  = recipe_unit_arr[recipe_arr.index(material)]
				recipe.save
			end
		end
	end
end
