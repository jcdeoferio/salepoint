class XactController < ApplicationController
  def index
    session[:sum] = params[:sum]
    session[:qty] = params[:qty]
  end
  def xact
    @xacts = Xact.all
  end
  
  def view
    @xacts = Xact.all
  end
  
  def xdetails
    @xact = Xact.find_by_id(params[:id])
    @details = @xact.xact_details.all
  end
  
  def create
    @xact = Xact.new()
    @xact.date = Date.today
    @xact.user_id = User.find_by_id(session[:u_id]).id
    if @xact.save
      session[:x_id] = @xact.id
      redirect_to :action => 'details'
    end
  end
  
  def details
    @curr_xact = Xact.find_by_id(session[:x_id])
    @details = @curr_xact.xact_details.all
    @products = ProductBranch.find_all_by_branch_id(User.find_by_id(session[:u_id]).branch_id)
  end
  
  def add_details
    @curr_xact = Xact.find_by_id(session[:x_id])
    @product = ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', Product.find_by_product_name(params[:product][:product_name]).id, User.find_by_id(session[:u_id]).branch_id]).first
    if @product!=nil
      @branch = ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', @product.id, User.find_by_id(session[:u_id]).branch_id]).first
    
      if (@branch.stock - params[:quantity][:qty].to_i) >= 0
        @detail = @curr_xact.xact_details.new()
        @detail.xact_id = @curr_xact.id
        @detail.product_id = @product.id
        @detail.update_attribute("quantity", params[:quantity][:qty])
        @detail.update_attribute("price", (Product.find_by_id(@product.product_id).unit_price * @detail.quantity))
        @branch.update_attribute("stock", (@branch.stock - @detail.quantity))
      
        session[:sum] = session[:sum].to_i + @detail.price
        session[:qty] = session[:qty].to_i + @detail.quantity
        
        if @detail.save
          @curr_xact.update_attribute("total", session[:sum])
          @curr_xact.update_attribute("qty", session[:qty])
          redirect_to :action => 'details'
        else
          flash[:error] = "Error in input."
          redirect_to :action => 'details'
        end
      else
        flash[:error] = "Product " + Product.find_by_id(@product.product_id).product_name + " is out of stock or stock is insufficient."
        redirect_to :action => 'details'
      end
    else
      flash[:error] = "Error in input."
      redirect_to :action => 'details'
    end
  end
  
  def xact_end
    @curr_xact = Xact.find_by_id(session[:x_id])
    @details = @curr_xact.xact_details.all
  end
  
  def destroy
    @xact = Xact.find_by_id(params[:id])
    flash[:notice] = "Successfully deleted transaction at " + @xact.created_at + "."
    @xact.destroy
    redirect_to :action => 'view'
  end
  
end
