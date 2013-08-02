class Relationship < ActiveRecord::Base
	belongs_to :fan, class_name: "User"
	belongs_to :followed, class_name: "User"
	validates :fan_id, presence: true
	validates :followed_id, presence: true

end
