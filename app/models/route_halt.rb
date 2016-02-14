class RouteHalt < ActiveRecord::Base
  belongs_to :route
  belongs_to :halt
  has_many :users

  enum type: [ :general, :source, :destination ]
end
