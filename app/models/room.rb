class Room < ApplicationRecord
	extend FriendlyId

	has_many :reviews, :dependent => :destroy
	belongs_to :user
	validates_presence_of :title, :location, :description, :slug
	validates :description, length: { in: 10..1024}

	mount_uploader :picture, PictureUploader
	friendly_id :title, :use => [:slugged, :history]

	scope :most_recent, -> { all.limit(3) }

	def complete_name
		"#{title}, #{location}"
	end

	def self.search(query)
		if query.present?
			where(['location ILIKE :query OR
				title ILIKE :query OR
				description ILIKE :query', :query => "%#{query}%"])
		else
			unscoped
		end
	end
end
