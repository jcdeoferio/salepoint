class ProductController < ApplicationController
  def product
    @products = Product.all
  end
  
  def add
    @product = Product.new(params[:product])
    
    if @product.save
      redirect_to :action => 'product'
    else
      redirect_to :action => 'new'
    end
  end
  
  def destroy
    @product = Product.find_by_product_name(params[:product])
    flash[:notice] = "Successfully deleted product " + @product.product_name
    @product.destroy
    redirect_to :action => 'product'
  end
end
