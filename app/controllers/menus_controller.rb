class MenusController < ApplicationController
	before_action :require_user
	def new
	end

	def index
		@tall_menus = Menu.where('menu_size = ?',2)
		@menus = Menu.where('menu_size = ?', 1)
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
			menu_order: params[:menu_order],
			menu_size: params[:menu_size],
			menu_promo: params[:menu_promo],
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
		menu.menu_order       = params[:menu_order]
		menu.menu_size       = params[:menu_size]
		menu.menu_promo       = params[:menu_promo].nil? ? false : params[:menu_promo]
		menu.menu_category_id = MenuCategory.where('category_code = ?', params[:menu_category]).take.id
		menu.save
		redirect_to menus_index_path
	end

	def recipe_new
		@menus = Menu.where('display = ?', true).all
		@materials = Material.where('display = ?', true).all
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
		@materials = Material.where('display = ?', true).all
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

	def engineering
		params[:start_date].nil? ? @start_date = Date.today - 1.month : @start_date = params[:start_date].to_date
		params[:end_date].nil? ? @end_date = Date.today : @end_date = params[:end_date].to_date
		details = Detail.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
		########## hot메뉴 메뉴엔지니어링 ###########
 		@hot_menus = Menu.where('menu_degree = ? AND display = ?', "1", true)
 		@hot_sales = []
 		@hot_menumix = []
 		@hot_margin = []
 		@hot_mean_margin = 0

 		## 메뉴 판매량 및 마진 산출
 		@hot_menus.each do |hot_menu|
 			if details.where('menu_id = ?', hot_menu.id).take.nil?
 				hot_sale = 0
 			else
 				hot_sale = details.where('menu_id = ?', hot_menu.id).sum("order_unit")
 			end
 			margin = (hot_menu.menu_price - hot_menu.unit_price).round(2)
 			@hot_sales << hot_sale
 			@hot_margin << margin
 			@hot_mean_margin += hot_sale * margin
 		end
 		## 메뉴별 믹스 산출
 		@hot_sales.each do |hot_sale|
 			if @hot_sales.sum == 0
 				@hot_menumix << 0
 			else
 				@hot_menumix << (hot_sale / @hot_sales.sum.to_f * 100).round(2)
 			end
 		end
 		## 메뉴믹스비율
 		@hot_menu_mix_ratio = (1 / @hot_menus.count.to_f * 0.7 * 100).round(2)
 		## 평균공헌마진
 		@hot_sales.sum == 0 ? @hot_mean_margin = 0 : @hot_mean_margin = (@hot_mean_margin / @hot_sales.sum).round(2)
 			

############################################################################################
 		########## ice메뉴 메뉴엔지니어링 ###########
 		@ice_menus = Menu.where('menu_degree = ? AND display = ?', "2", true)
 		@ice_sales = []
 		@ice_menumix = []
 		@ice_margin = []
 		@ice_mean_margin = 0

 		## 메뉴 판매량 및 마진 산출
 		@ice_menus.each do |ice_menu|
 			if details.where('menu_id = ?', ice_menu.id).take.nil?
 				ice_sale = 0
 			else
 				ice_sale = details.where('menu_id = ?', ice_menu.id).sum("order_unit")
 			end
 			margin = (ice_menu.menu_price - ice_menu.unit_price).round(2)
 			@ice_sales << ice_sale
 			@ice_margin << margin
 			@ice_mean_margin += ice_sale * margin
 		end
 		## 메뉴별 믹스 산출
 		@ice_sales.each do |ice_sale|
 			if @ice_sales.sum == 0
 				@ice_menumix << 0
 			else
 				@ice_menumix << (ice_sale / @ice_sales.sum.to_f * 100).round(2)
 			end
 		end
 		## 메뉴믹스비율
 		@ice_menu_mix_ratio = (1 / @ice_menus.count.to_f * 0.7 * 100).round(2)
 		## 평균공헌마진
 		@ice_sales.sum == 0 ? @ice_mean_margin = 0 : @ice_mean_margin = (@ice_mean_margin / @ice_sales.sum).round(2)
	end

end
