class ProductController < ApplicationController
	def index
	  @curr_user = User.find_by_id(session[:u_id])
	  if @curr_user.role != 'Administrator'
	    @products = ProductBranch.find_all_by_branch_id(@curr_user.branch_id)
	  else
		@products = Product.all
		@pbranch = ProductBranch.all
	  end
	end

	def new
	  @curr_user = User.find_by_id(session[:u_id])
	end
	
	def create
	  @curr_user = User.find_by_id(session[:u_id])
	  @p = Product.find_by_product_name(params[:product][:product_name])
	  if @p==nil
		@product = Product.new(params[:product])
		if @product.save
			@productb = @product.product_branches.new()
			@productb.product_id = @product.id
			if @curr_user.role == 'Administrator'
			  @productb.update_attribute("branch_id", Branch.find_by_branch_name(params[:branch][:name]).id)
			  #session[:b_id] = Branch.find_by_branch_name(params[:branch][:name]).id
			else
			  @productb.update_attribute("branch_id", @curr_user.branch_id)
			  #session[:b_id] = @curr_user.branch_id
			end
			@productb.update_attribute("stock", params[:stockno][:stock])
			redirect_to :action => 'index'
			flash[:notice] = "Successfully added new product."
		else
		  flash[:error] = "Error in input."
		  redirect_to :action => 'new'
		end
	  elsif (@curr_user.role=='Manager' and ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', @p.id, @curr_user.branch_id]).first==nil)
	      @productb = @p.product_branches.new()
		  @productb.product_id = @p.id
		  @productb.update_attribute("branch_id", @curr_user.branch_id)
		  @productb.update_attribute("stock", params[:stockno][:stock])
		  #session[:b_id] = @curr_user.branch_id
		  redirect_to :action => 'index'
		  flash[:notice] = "Successfully added new product."
	  else
	      flash[:error] = "Product " + params[:product][:product_name] + " already exists."
	      redirect_to :action => 'new'
	  end
	end
    
	def edit
	  if (@curr_user = User.find_by_id(session[:u_id])).role == 'Manager'
    	session[:p_id] = (@product = Product.find_by_id(params[:id])).id
 	    #session[:b_id] = @curr_user.branch_id
 	  else
 	    @product = Product.find_by_id(session[:p_id])
 	    #session[:b_id] = Branch.find_by_branch_name(params[:branch][:name]).id
 	  end
	end
	
	def editf
	  session[:p_id] = Product.find_by_id(params[:id]).id
	end

	def update
		@product = Product.find_by_id(session[:p_id])
		if @product.update_attributes(params[:product])
		  @branch = ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', @product.id, Branch.find_by_id(session[:b_id]).id]).first
		  @branch.update_attribute("stock", params[:stockno][:stock])
		  flash[:notice] = "Successfully edited product " + @product.product_name
		  redirect_to :action => 'index'
		else
		  flash[:error] = "Error in input."
		  redirect_to :action => 'edit'
		end
	end
  
    def destroy_admin
      session[:p_id] = Product.find_by_id(params[:id]).id
    end
  
	def destroy
		if User.find_by_id(session[:u_id]).role=='Manager'
		  @product = Product.find_by_id(params[:id])
		  @productb = ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', @product.id, User.find_by_id(session[:id]).branch_id]).first
		else
		  @product = Product.find_by_id(session[:p_id])
		  @productb = ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', @product.id, Branch.find_by_branch_name(params[:branch][:name]).id]).first
		end
		if ProductBranch.find_all_by_product_id(@product.id).size == 1
		  @product.destroy
		end
		@productb.destroy
		flash[:notice] = "Successfully deleted product"
		redirect_to :action => 'index'
	end
	  
    def branch
      session[:p_id] = (@product = Product.find_by_id(params[:id])).id
    end
  
    def add_branch
      @branch = ProductBranch.new()
      if @branch.save
        @branch.update_attribute("branch_id", Branch.find_by_branch_name(params[:branch][:branch_name]).id)
        @branch.update_attribute("product_id", Product.find_by_id(session[:p_id]).id)
        @branch.update_attribute("stock", params[:branch][:stock])
        flash[:notice] = "Successfully added new branch for product " + Product.find_by_id(session[:p_id]).product_name + "."
        redirect_to :action => 'index'
      else
        flash[:error] = "Error in input."
        redirect_to :action => 'branch'
      end
    end
	
end
