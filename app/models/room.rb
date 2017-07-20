class Room < ApplicationRecord
	has_many :reviews, :dependent => :destroy
	belongs_to :user
	validates_presence_of :title, :location, :description
	validates :description, length: { in: 10..1024}

	scope :most_recent, -> { all.limit(3) }

	def complete_name
		"#{title}, #{location}"
	end

end
