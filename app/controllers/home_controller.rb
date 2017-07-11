class HomeController < ApplicationController
	def index
		@rooms = Room.first(3)
	end
end
