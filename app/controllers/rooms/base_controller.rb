class Rooms::BaseController < ApplicationController
  before_action :require_authentication

  private

  def room
    @room ||= Rooms.find(params[:id])
  end
end
