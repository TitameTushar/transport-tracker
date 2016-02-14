class Vehicle < ActiveRecord::Base
	has_many :users
	belongs_to :route
end
