class Rating < ActiveRecord::Base
  belongs_to :rate
  belongs_to :rateable, polymorphic: true
end
