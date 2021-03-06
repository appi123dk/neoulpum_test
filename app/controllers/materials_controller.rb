class MaterialsController < ApplicationController
	before_action :require_user
	def index
		@materials = Material.all
	end

	def edit
		@material = Material.find(params[:id])
		@semesters = Semester.where('year = ?', Date.today().year().to_s)
	end

	def update
		material = Material.find(params[:id])
		material.material_name      = params[:material_name]
		material.material_buyer     = params[:material_buyer]
		material.material_url       = params[:material_url]
		material.material_volume    = params[:material_volume]
		material.material_unit      = params[:material_unit]
		material.material_limit     = params[:material_limit]
		material.material_price     = params[:material_price]
		material.material_shipping  = params[:material_shipping]
		material.material_order     = params[:material_order]
		material.employee_id     = params[:employee_id]
		material.scale = params[:material_scale]
		material.save

		redirect_to '/materials/index'
	end

	def check_index
		@materials = Material.where('display = ?', true).order("material_order")
	end

	def check_create
		storage_date = Date.strptime(params[:date],'%m/%d/%Y').to_formatted_s(:db)
		storage_id_arr     = params[:material_num]
		storage_unit_arr   = params[:material_unit]
		storage_id_arr2    = params[:material_num2]
		storage_unit_arr2  = params[:material_unit2]
		date_check         = Storage.where('storage_date = ?',storage_date).take
		if date_check.nil?
			# 재고체크 코드
			Storage.check_storage storage_id_arr, storage_unit_arr, storage_date
			Storage.check_storage storage_id_arr2, storage_unit_arr2, storage_date
		end

		redirect_to '/materials/check_index'

	end

	def check
		@materials = Material.where('display = ?', true).order("material_order")
		@all_count = @materials.count
		count = @materials.count/2
		@all_count.even? ? @counts = count - 1 : @counts = count
	end

	def new
		@semesters = Semester.where('year = ?', Date.today().year().to_s)
	end

	def delete
		material = Material.find(params[:id])
		material.display = !material.display
		material.save
		redirect_to '/materials/index'
	end	

	def create
		material = Material.new
		material.material_name      = params[:material_name]
		material.material_buyer     = params[:material_buyer]
		material.material_url       = params[:material_url]
		material.material_volume    = params[:material_volume]
		material.material_unit      = params[:material_unit]
		material.material_limit     = params[:material_limit]
		material.material_price     = params[:material_price]
		material.material_shipping  = params[:material_shipping]
		material.scale              = params[:material_scale]
		material.material_order     = params[:material_order]
		material.employee_id     = params[:employee_id]
		material.save

		redirect_to '/materials/index'

	end

	def check_edit
		storage_date = Date.strptime(params[:date],'%m/%d/%Y')
		@materials = Material.where('display = ?', true).order("material_order")
		@all_count = @materials.count
		count = @materials.count/2
		@all_count.even? ? @counts = count - 1 : @counts = count
		@storages = Storage.where('storage_date = ?', storage_date)
	end

	def check_update
		storage_date = Date.strptime(params[:date],'%m/%d/%Y').to_formatted_s(:db)
		storage_id_arr     = params[:material_num]
		storage_unit_arr   = params[:material_unit]
		storage_id_arr2    = params[:material_num2]
		storage_unit_arr2  = params[:material_unit2]

		# 재고체크 업데이트 코드
		Storage.update_storage storage_id_arr, storage_unit_arr, storage_date
		Storage.update_storage storage_id_arr2, storage_unit_arr2, storage_date

		redirect_to '/materials/check_index'
	end

	def edit_price
		menus = Menu.all
		menus.each do |menu|
			unit_price = 0
			Recipe.where('menu_id = ?',menu.id).each do |recipe|
				m = Material.find(recipe.material_id)
				unless recipe.material_unit == nil
					unit_price += ((m.material_price / m.material_unit) / m.material_volume.to_f)*recipe.material_unit.to_f
				end
			end
			menu.unit_price = unit_price
			menu.save
		end

		redirect_to '/menus/index'
	end

	def request_buy
		#이번학기 구하는 로직
		year = Date.today.year
		semester = Date.today.month / 6 > 1 ? 1 : 2
		@materials = Material.where('display = ?', true).all.order("material_name")
		@employees = Semester.where('year = ? AND semester = ?', year, semester).take.teams
		@requests = Cost.where('buy_pament = ?', false)
	end

	def material_price
		@material_price = Material.find(params[:material_id])
		render json: @material_price
	end

	def is_order
		material = Material.find(params[:id])
		if material.is_order
			material.is_order = false
			material.order_date = Date.today()
		else 
			material.is_order = true
			material.order_date = Date.today()
		end
		material.save
		redirect_to '/materials/check_index'
	end

end
