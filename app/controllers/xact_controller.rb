class XactController < ApplicationController
  $sum = 0
  def xact
    @xacts = Xact.all
  end
  
  def create
    @xact = Xact.new()
    @xact.date = Date.today
    @xact.user_id = User.find_by_userid(session[:userid]).id
    if @xact.save
      session[:x_id] = @xact.id
      redirect_to :action => 'details'
    end
  end
  
  def details
    @curr_xact = Xact.find_by_id(session[:x_id])
    @details = @curr_xact.xact_details.all
  end
  
  def add_details
    @curr_xact = Xact.find_by_id(session[:x_id])
    @product = Product.find_by_product_name(params[:product][:product_name])
    @branch = ProductBranch.all(:conditions => ['product_id=? AND branch_id=?', @product.id, User.find_by_userid(session[:userid]).branch_id]).first
    
    @detail = @curr_xact.xact_details.new()
    @detail.xact_id = @curr_xact.id
    @detail.product_id = @product.id
    @detail.update_attribute("quantity", params[:quantity][:qty])
    @detail.update_attribute("price", (@product.unit_price * @detail.quantity))
    @branch.update_attribute("stock", (@branch.stock - @detail.quantity))
    
    $sum += @detail.price
  
    if @detail.save
      @curr_xact.update_attribute("total", $sum)
      redirect_to :action => 'details'
    else
      redirect_to :action => 'transaction_end'
    end
  end
  
  def xact_end
    @curr_xact = Xact.find_by_id(session[:x_id])
    @details = @curr_xact.xact_details.all
  end
  
end
