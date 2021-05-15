class HomesController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(5)
  end

  def create_order
    @products = Product.find(params[:home_id])
    if request.post?
      customer_name = params['name']
      address = params['address']
      tell = params['tell']
      amount = params['amount']
      @user = @products.user.create(product_id: @product, name: customer_name, address: address, tell: tell)

      redirect_to '/'
    end
  end

end
