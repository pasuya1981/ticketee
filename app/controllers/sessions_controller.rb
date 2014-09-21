class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.where(:name => signin_params[:name]).first

  	if user && user.authenticate(signin_params[:password])
  	  session[:user_id] = user.id
  	  flash[:notice] = "Signed in successfully."
  	  redirect_to root_url
  	else
  	  flash.now[:error] = 'Sorry!'
  	  render :new
  	end
  end

  private

    def signin_params
      params.require(:signin).permit(:name, :password)
    end
end