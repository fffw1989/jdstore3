class Admin::ProductsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @categories = Category.all.map { |c| [c.name, c.id]}
    @photo = @product.photos.build #for multi-pics
  end

  def create
    @product = Product.new(product_params)
    @product.category_id = params[:category_id]

    if @product.save
        if params[:photos] != nil
         params[:photos]['avatar'].each do |a|
           @photo = @product.photos.create(:avatar => a)
         end
        end
      redirect_to admin_products_path,notice:"创建成功！"

    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def update
    @product = Product.find(params[:id])
    @product.category_id = params[:category_id]

     if params[:photos] != nil
       @product.photos.destroy_all   #先清除原有的图片

       params[:photos]['avatar'].each do |a|
         @photo = @product.photos.create(:avatar => a)
       end
     end

    if @product.update(product_params)
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, alert:'Product deleted!'
  end


  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :quantity, :category_id)
  end
end
