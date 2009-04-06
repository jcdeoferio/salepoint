class ProductController < ApplicationController
	def index
		@products = Product.all
		@product = Product.find_by_id(params[:id])
		@curr_user = User.find_by_userid(session[:userid])
	end

	def new
	end
	
	def create
		@product = Product.new(params[:product])
		if @product.save
			@productb = @product.product_branches.new()
			@productb.product_id = @product.id
			@productb.branch_id = User.find_by_userid(session[:userid]).branch_id
			if @product.ptype
				@productb.update_attribute("stock", params[:stockno][:stock])
				redirect_to :action => 'index'
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
    
	def details
		@product = Product.find_by_id(session[:id])
		@details = @product.product_details.all
	end
  
	def add_details
		@product = Product.find_by_id(session[:id])
		@productd = @product.product_details.new()
		#@productd.pd_id = @product.id
		@productd.product_id = Product.find_by_product_name(params[:product][:product_name]).id
		if @productd.save
		  redirect_to :action => 'details'
		else
		  redirect_to :action => 'index'
		end
	end
  
	def edit
		session[:p_id] = (@product = Product.find_by_id(params[:id])).id
	end

	def update
		@product = Product.find_by_id(session[:p_id])
		if @product.update_attributes(params[:product])
		  flash[:notice] = "Successfully edited product " + @product.product_name
		  redirect_to :action => 'index'
		else
		  redirect_to :action => 'index'
		end
	end
  
	def destroy
		@product = Product.find_by_id(params[:id])
		flash[:notice] = "Successfully deleted product"
		@product.destroy
		redirect_to :action => 'index'
	end
	
	 def add_package
    @products = Product.find(:all,:conditions => ['ptype != ?',5])
    @productsF = Array.new
    for prod in @products
      @productsF[prod.id] = prod
    end
    if(defined?params[:product] and defined?params[:products])
      
      @prods = params[:products]
      @package = params[:product]
  
      @prod = Product.new params[:product]
      @prod.update_attribute("ptype", 5)

      if @prod.save
        @productb = @prod.product_branches.new()
        @productb.product_id = @prod.id
        @productb.branch_id = User.find_by_userid(session[:userid]).branch_id
        session[:id] = @prod.id
        @productb.save
      end
      
#      for productid in @prods
#        @pd = Product_details.new productid
#        @prod.update_attribute("ptype", 5)
#        @pd.save
#      end
    end
  end
	
end
