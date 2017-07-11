class UsersController < ApplicationController
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
end
