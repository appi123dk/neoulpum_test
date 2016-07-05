class Storage < ActiveRecord::Base
	has_many :materials

	def self.check_storage storage_arr, storage_unit_arr ,storage_date
		storage_arr.each do |material|
			storage = Storage.new
			storage.storage_date  = storage_date
			storage.material_id   = material
			storage.storage_unit  = storage_unit_arr[storage_arr.index(material)]
			storage.save
		end
	end

	def self.update_storage storage_arr, storage_unit_arr ,storage_date
		storage_arr.each do |material|
			storage = Storage.where('storage_date=? AND material_id = ?', storage_date, material).take
			if storage.nil?
				storage = Storage.new
				storage.storage_date  = storage_date
				storage.material_id   = material
				storage.storage_unit  = storage_unit_arr[storage_arr.index(material)]
				storage.save
			else
				storage.storage_unit = storage_unit_arr[storage_arr.index(material)]
				storage.save
			end
		end		
	end	
end
