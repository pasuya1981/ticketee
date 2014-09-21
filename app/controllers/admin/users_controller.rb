class Admin::UsersController < Admin::BaseController

  before_action :set_user, only: [:show, :update, :edit, :delete]

  def index
  	@users = User.order(:email)
  end

  def show
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	@user.password_confirmation = user_params[:passowrd]


  	if @user.save
  	  redirect_to admin_users_url, notice: "User has been created."
  	else
  	  flash.now[:alert] = "User has not been created."
  	  render :action => 'new'
  	end
  end

  def edit
  	
  end

  def update

    # On the user update form,
    # if user leave password field blank, the passed params[:password] would be empty string "",
    # so we have to delete params[:password] & params[:password_confirmation]
    # instead save empty string into database password_diget column.
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

  	if @user.update(user_params)
  	  redirect_to [:admin, :users], notice: 'User has been updated.'
  	else
  	  flash.now[:alert] = 'User has not been updated.'
  	  render :edit
  	end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
end
