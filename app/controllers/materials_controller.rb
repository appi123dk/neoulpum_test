# encoding: utf-8
class MaterialsController < ApplicationController
	def index
		@materials = Material.all
	end

	def edit
		@material = Material.find(params[:id])
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
		material.save

		redirect_to '/materials/index'
	end

	def check_index
		@materials = Material.all
	end

	def check_create
		storage_date = Date.strptime(params[:date],'%m/%d/%Y')
		storage_id_arr     = params[:material_num]
		storage_unit_arr   = params[:material_unit]
		storage_id_arr2    = params[:material_num2]
		storage_unit_arr2  = params[:material_unit2]
		date_check         = Storage.where('storage_date = ?',storage_date.to_formatted_s(:db)).take
		if date_check.nil?
			storage_id_arr.each do |material|
				storage = Storage.new
				storage.storage_date  = storage_date.to_formatted_s(:db)
				storage.material_id   = material
				storage.storage_unit  = storage_unit_arr[storage_id_arr.index(material)]
				storage.save
			end
			storage_id_arr2.each do |material|
				storage = Storage.new
				storage.storage_date  = storage_date.to_formatted_s(:db)
				storage.material_id   = material
				storage.storage_unit  = storage_unit_arr2[storage_id_arr2.index(material)]
				storage.save
			end
		end

		redirect_to '/materials/check_index'

	end

	def check
		@materials = Material.all
	end

	def new
		
	end

	def delete
		material = Material.find(params[:id])
		material.destroy
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
		material.save

		redirect_to '/materials/index'

	end

	def check_edit
		storage_date = Date.strptime(params[:date],'%m/%d/%Y')
		@materials = Material.all
		@storages = Storage.where('storage_date = ?', storage_date)
	end

	def check_update
		storage_date = Date.strptime(params[:date],'%m/%d/%Y').to_formatted_s(:db)
		storage_id_arr     = params[:material_num]
		storage_unit_arr   = params[:material_unit]
		storage_id_arr2    = params[:material_num2]
		storage_unit_arr2  = params[:material_unit2]
		storage_id_arr.each do |material|
			storage = Storage.where('storage_date=? AND material_id = ?', storage_date, material).take
			if storage.nil?
				storage = Storage.new
				storage.storage_date  = storage_date
				storage.material_id   = material
				storage.storage_unit  = storage_unit_arr[storage_id_arr.index(material)]
				storage.save
			else
				storage.storage_unit = storage_unit_arr[storage_id_arr.index(material)]
				storage.save
			end
		end
		storage_id_arr2.each do |material|
			storage = Storage.where('storage_date=? AND material_id = ?', storage_date, material).take
			if storage.nil?
				storage = Storage.new
				storage.storage_date  = storage_date
				storage.material_id   = material
				storage.storage_unit  = storage_unit_arr2[storage_id_arr2.index(material)]
				storage.save
			else
				storage.storage_unit = storage_unit_arr2[storage_id_arr2.index(material)]
				storage.save
			end
		end

		redirect_to '/materials/check_index'
	end

	def edit_price
		menus = Menu.all
		menus.each do |menu|
			menu_price = 0
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

	## material DB content
	# 재료명, 거래처명, 거래처 사이트 주소, 용량, 구매갯수, 구매마지노선, 배송일수, 가격
	# 만약 전날대비 재고가 증가한다면 구매한것으로 간주
	
	## storage DB content
	# material_id, 갯수, 체크 날짜
	# 최근 1주일간의 재고체크 기록을 뿌려줌

	## recipe DB content
	# menu_id, material_id, 재료의 갯수
	# 재료 평균 가격 / (구매갯수*용량) * 재료의 갯수 = 해당 메뉴에 들어가는 레시피의 단가 산출
	# 각 메뉴의 단가 입력 -> menu DB에 단가 컬럼 생성 
	# 정산 DB에서 가격을 곱하여 그래프 뿌려줌
end
