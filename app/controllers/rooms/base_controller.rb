class Rooms::BaseController < ApplicationController
  before_filter :require_authentication

  private

  def room
    @room ||= Rooms.find(params[:id])
  end
end
