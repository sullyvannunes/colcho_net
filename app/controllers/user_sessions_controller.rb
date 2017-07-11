class UserSessionsController < ApplicationController
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
      #TODO sessão do usuario
    end
end
