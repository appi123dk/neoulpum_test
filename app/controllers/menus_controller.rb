# encoding: utf-8
class MenusController < ApplicationController
	def new
	end

	def index

		@menus = Menu.all
	end

	def delete
		@menu = Menu.find(params[:id])
		@menu.destroy

		redirect_to menus_index_path
	end

	def edit
		@menu = Menu.find(params[:id])
	end

	def update
		menu = Menu.find(params[:id])
		menu.update(
			menu_title: params[:menu_title],
			menu_symbol: params[:menu_symbol],
			menu_degree: params[:menu_degree],
			menu_price: params[:menu_price],
			menu_category_id: MenuCategory.where('category_code = ?', params[:menu_category]).take.id
			)
		redirect_to menus_index_path
	end

	def create
		menu = Menu.new
		menu.menu_title       = params[:menu_title]
		menu.menu_symbol      = params[:menu_symbol]
		menu.menu_degree      = params[:menu_degree]
		menu.menu_price       = params[:menu_price]
		menu.menu_category_id = MenuCategory.where('category_code = ?', params[:menu_category]).take.id
		menu.save
		redirect_to menus_index_path
	end

	def recipe_new
		@menus = Menu.all
		@materials = Material.all
	end

	def recipe_create
		recipe_id_arr     = params[:material_num]
		recipe_unit_arr   = params[:material_unit]
		recipe_id_arr2    = params[:material_num2]
		recipe_unit_arr2  = params[:material_unit2]

		if Recipe.where('menu_id=?',params[:menu]).take.nil?
			recipe_id_arr.each do |material|
				recipe = Recipe.new
				recipe.menu_id        = params[:menu].to_i
				recipe.material_id    = material
				recipe.material_unit  = recipe_unit_arr[recipe_id_arr.index(material)]
				recipe.save
			end
			recipe_id_arr2.each do |material|
				recipe = Recipe.new
				recipe.menu_id        = params[:menu].to_i
				recipe.material_id    = material
				recipe.material_unit  = recipe_unit_arr2[recipe_id_arr2.index(material)]
				recipe.save
			end

			# 메뉴 단가 입력
			menu = Menu.find(params[:menu].to_i)
			menu_price = menu.unit_price.to_f
			Recipe.where('menu_id = ?',menu.id).each do |recipe|
				m = Material.find(recipe.material_id)
				unless recipe.material_unit == nil
					menu_price += ((m.material_price / m.material_unit) / m.material_volume.to_f)*recipe.material_unit.to_f
				end
			end
			menu.unit_price = menu_price
			menu.save
		end

		redirect_to '/menus/index'
	end

	def recipe_index
		@recipes = Recipe.where('menu_id=?', params[:id])
		@icon = ['leaf','coffee','cutlery','glass','tint']
		if @recipes.first.nil?
			redirect_to '/menus/index'
		end
	end

	def recipe_edit
		@recipes = Recipe.where('menu_id=?',params[:id])
		@materials = Material.all
	end

	def recipe_update
		recipe_id_arr     = params[:material_num]
		recipe_unit_arr   = params[:material_unit]
		recipe_id_arr2    = params[:material_num2]
		recipe_unit_arr2  = params[:material_unit2]
		recipes = Recipe.where('menu_id=?', params[:id])
		materials = Material.all

		recipe_id_arr.each do |material|
			recipe = recipes.where('material_id=?', material).take
			recipe.material_unit  = recipe_unit_arr[recipe_id_arr.index(material)]
			recipe.save
		end
		recipe_id_arr2.each do |material|
			recipe = recipes.where('material_id=?', material).take
			recipe.material_unit  = recipe_unit_arr2[recipe_id_arr2.index(material)]
			recipe.save
		end

		# 메뉴 단가 입력
		menu = Menu.find(params[:id])
		menu_price = 0
		recipes.each do |recipe|
			m = materials.find(recipe.material_id)
			unless recipe.material_unit == nil
				menu_price += ((m.material_price / m.material_unit) / m.material_volume.to_f)*recipe.material_unit.to_f
			end
		end
		menu.unit_price = menu_price
		menu.save

		redirect_to "/menus/recipe_index/#{menu.id}"
	end

end
