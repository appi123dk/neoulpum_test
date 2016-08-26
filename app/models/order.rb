class Order < ActiveRecord::Base
	has_and_belongs_to_many :users, dependent: :destroy
	has_many :details, dependent: :destroy
end
