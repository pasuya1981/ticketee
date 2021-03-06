class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :delete]

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
      session[:user_id] = @user.id
  	  redirect_to '/', notice: 'You have signed up successfully.'
  	else
  	  render action: 'new'
  	end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile has been updated.'
    else
      flash.now[:alert] = 'Profile has not been updated.'
      render action: :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
 	  params.require(:user).permit(:name, :email, :password, :password_confirmation)    	
    end
end
