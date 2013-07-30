class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit,:update,:index]
  before_action :corrent_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
  	@user= User.new
  end
  def show
  	@user = User.find(params[:id])
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Weclome to the Micropost App"
  		redirect_to @user
  	else
  		render 'new'
  	end
  	
  end

  def edit
    # @user=User.find(params[:id])
  end

  def update
    # @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "Update success"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page:params[:page], per_page:20)

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end



  private
  	def user_params
  		params.require(:user).permit(:name,
  				                         :email,
  				                         :password,
  				                         :password_confirmation)
  	end
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end
    def corrent_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user? @user
    end
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
