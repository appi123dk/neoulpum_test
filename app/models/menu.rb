class Menu < ActiveRecord::Base
	belongs_to :menu_category
	belongs_to :recipe
	has_many :details
	has_many :sale

	def self.calculate_unit_price menu_id
		menu = Menu.find(menu_id)
		recipes = Recipe.where('menu_id = ?', menu_id)
		menu_price = 0.to_f
		recipes.each do |recipe|
			m = Material.find(recipe.material_id)
			unless recipe.material_unit == nil
				menu_price += ((m.material_price / m.material_unit) / m.material_volume.to_f)*recipe.material_unit.to_f
			end
		end
		menu.unit_price = menu_price
		menu.save	
	end
end
