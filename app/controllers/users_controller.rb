class UsersController < ApplicationController

  # 
  def show
  	@user = User.find(params[:id])
  	# debugger
  end

  # routes.rb ---> get 'signup' => 'users#new'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end # end create

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
