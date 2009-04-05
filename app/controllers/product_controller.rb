class ProductController < ApplicationController
  def product
    @products = Product.all
    @curr_user = User.find_by_userid(session[:userid])
  end
  
  def add
    @product = Product.new(params[:product])
    
    if @product.save
      @productb = @product.product_branches.new()
      @productb.product_id = @product.id
      @productb.branch_id = User.find_by_userid(session[:userid]).branch_id
      if @product.ptype
        @productb.update_attribute("stock", params[:stockno][:stock])
        redirect_to :action => 'product'
        flash[:notice] = "Successfully added new product."
      else
        @product.update_attribute("ptype", 5)
        session[:id] = @product.id
        redirect_to :action => 'details'
      end
    else
      redirect_to :action => 'new'
    end
  end
  
  def package_add
    @product = Product.find_by_id(session[:id])
    @productd = @product.details.new()
    #@productd.pd_id = @product.id
    @productd.product_id = Product.find_by_product_name(params[:product][:product_name]).id
    if @product.save
      redirect_to :action => 'details'
    else
      redirect_to :action => 'product'
    end
  end
  
  def update
    @product = Product.find_by_product_name(params[:product][:product_name])
    if @product.update_attributes(params[:product])
      redirect_to :action => 'product'
    else
      redirect_to :action => 'new'
    end
  end
  
  def destroy
    @product = Product.find_by_product_name(params[:product][:product_name])
    flash[:notice] = "Successfully deleted product " + @product.product_name
    @product.destroy
    redirect_to :action => 'product'
  end
end
