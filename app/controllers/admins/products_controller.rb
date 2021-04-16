class Admins::ProductsController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]
  def index
    @search = params[:search]
    @products = Product.all
    @products = @products.where("title LIKE? or body LIKE ?", "%#{@search}%", "%#{@search}%") if @search.present?
    @products = @products.page(params[:page]).per(7)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(Product.all), file_name: 'products.csv' }
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    puts "This is how you print out sth."
    @product = Product.new
  end
  
  def create
    @product = Product.create(product_params)
    if @product.invalid?
      flash[:error] = @product.errors.full_messages
    end
    redirect_to action: :index
  end

  def edit
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to action: :index
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: :index
  end

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(",").map(&:strip)
      Product.create title: attr[0], description: attr[1], price: attr[2], stock: attr[3]
    end
    redirect_to action: :index
  end

  def delete_image_attachment
    @images = ActiveStorage::Attachment.find(params[:id])
    @images.purge
    redirect_to action: :edit
  end

  private

  def generate_csv(products)
    products.map {|a| [a.title, a.description, a.price, a.stock, a.updated_at.to_date].join(',') }.join("\n")
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :stock, :status, :preview_image, category_ids: [], images: [])
  end
end
