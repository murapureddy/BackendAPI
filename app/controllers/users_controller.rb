class UsersController < ApplicationController
	#before_action :set_user,only: [:show,:edit,:update,:destroy]
def index
  if params[:search]!="undefined"
    @users = User.where("first_name LIKE ? or email Like ?","%#{params[:search]}%","%#{params[:search]}%")
  else
    @users = User.all
  end
  render :json =>{users: @users,status: 200} 
end
 
 def show
 	@user = User.find(params[:id])
    render :json =>{user: @user,status: 200}
 end
 
 def new
    @user = User.new
 end
 
 def edit
 	@user = User.find(params[:id])
   render :json =>{user: @user,status: 200}
 end

 def sign_in

 end

  # def user_sign_in
  # if params[:email].present? && params[:password].present?
  #  @user = User.where(email: params[:email],password: params[:password]).first
  #  if @user.present?
  #   session[:user]=@user.id
  #   redirect_to '/posts'
  #  else
  #   flash[:notice]="Invalid username and password"
  #  end
  # end
  # end
 
 def create
 	debugger
    @user = User.new(user_params)
    if @user.save
      flash[:notice]="The user was sucessfully created"
      redirect_to @user
    else
      render 'new'
    end
  end
 
  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="The user was sucessfully updated"
      redirect_to '/users'
    else
      render 'edit'
    end
  end

  def logout
    reset_session
    flash[:notice] = "This user has been successfully logged out"
    redirect_to '/'
 end
 def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to '/users'
 end

  #def set_user
   #  @user = User.find(params[:id])
  #end
 
  private
    def user_params
      params.require(:user).permit(:first_name, :email,:password,:image,address: {})
    end
end
