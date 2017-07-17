class UsersController < ApplicationController
	before_action :require_no_authentication, :only => [:new, :create]
	before_action :can_change, :only => [:edit, :update]
	include ActiveModel::ForbiddenAttributesProtection
	def new
		@user = User.new
	end

	def index
		@user = User.all
	end

	def update
	end

	def create
		@user = User.new params
			.require(:user)
			.permit(:full_name, :location, :email, :password, :password_confirmation, :bio)
		if @user.save
			SignupMailer.confirm_email(@user).deliver
			redirect_to @user, :notice => 'Cadastro realizado com sucesso!'

		else
			render :new
		end

	end

	def show
		@user = User.find(params[:id])
	end

	def delete
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes params.require(:user).permit(:full_name,:location, :email, :password, :password_confirmation, :bio)
			redirect_to @user, :notice => 'Cadastro atualizado com sucesso!'
		else
			render :edit
		end
	end

	private

	def can_change
		#se o usuario não estiver logado ou acesssar o perfil de outro usuario
		#redireiona para a paginal inicial correspondente ao params[:id]
		unless user_signed_in? && current_user == user
			redirect_to user_path(params[:id]), :notice => 'Sem autorização para alterar outro perfil'
		end
	end

	def user
		@user ||= User.find(params[:id])
	end
end
