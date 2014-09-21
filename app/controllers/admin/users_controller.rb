class Admin::UsersController < Admin::BaseController

  def index
  	@users = User.order(:email)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.password_confirmation = user_params[:passowrd]

  	puts "#{params}".red

  	if @user.save
  	  redirect_to admin_users_url, notice: "User has been created."
  	else
  	  flash.now[:alert] = "User has not been created."
  	  render :action => 'new'
  	end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
end