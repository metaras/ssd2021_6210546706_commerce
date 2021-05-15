class UsersController < ApplicationController

  def index
    @users = User.all
    @users = @users.page(params[:page]).per(7)
  end

  def show
    @users = User.find(params[:id])
    @product = Product.find(@users.product_id)
  end

  def new 
    @users = User.new 
  end

  def create 
    @users = User.create(user_params)
    if @users.invalid?
      flash[:error] = @users.errors.full_messages
    end

    redirect_to action: :index

  end

  def edit 
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to action: :index
  end

  def destroy
    @product = User.find(params[:id])
    @product.destroy
    redirect_to action: :index
  end

  def user_params
    params.require(:user).permit(:name, :address, :tell, :amount)
  end

end
