class Route < ActiveRecord::Base
	has_many :route_halts, dependent: :destroy
	has_many :halts, through: :route_halts
	has_many :vehicles
end
