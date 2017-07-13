class UserSessionsController < ApplicationController
  before_action :require_no_authenticate, :only => [:new, :create]
  before_action :require_authenticate, :only => :destroy
  def new
    @session = UserSession.new(session)
  end

  def create
    @session = UserSession.new(session, params.require(:user_session).permit(:email, :password))
    if @session.authenticate
      redirect_to root_path, :notice => t('flash.notice.signed_in')
    else
      render :new
    end
  end

  def destroy
    user_session.destroy
    redirect_to root_path, :notice => t('flash.notice.signed_out')
  end
end
