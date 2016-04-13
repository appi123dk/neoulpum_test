class Account < ActiveRecord::Base
	validates :account_date, uniqueness: true
end
