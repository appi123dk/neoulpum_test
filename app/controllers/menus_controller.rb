class MenusController < ApplicationController
	before_action :require_user
	def new
	end

	def index

		@menus = Menu.all
	end

	def delete
		@menu = Menu.find(params[:id])
		if @menu.display
			@menu.display = false
		else 
			@menu.display = true
		end
		@menu.save

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
			# 레시피 등록
			Recipe.make_recipe params[:menu], recipe_id_arr, recipe_unit_arr
			unless recipe_id_arr2.nil?
				Recipe.make_recipe params[:menu], recipe_id_arr2, recipe_unit_arr2
			end

			# 메뉴 단가 입력
			Menu.calculate_unit_price params[:menu]
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
		menu_id = params[:id]
		# 레시피 업데이트
		Recipe.update_recipe menu_id, recipe_id_arr, recipe_unit_arr
		unless recipe_id_arr2.nil?
			Recipe.update_recipe menu_id, recipe_id_arr2, recipe_unit_arr2
		end

		# 메뉴 단가 입력
		Menu.calculate_unit_price menu_id

		redirect_to "/menus/recipe_index/#{menu_id}"
	end

end
