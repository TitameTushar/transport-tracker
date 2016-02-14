class Halt < ActiveRecord::Base
	has_many :route_halts, dependent: :destroy
	has_many :routes, through: :route_halts
end
