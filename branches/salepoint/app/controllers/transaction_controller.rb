class TransactionController < ApplicationController
  def transaction
    @transactions = Transaction.all
  end
  
  def create
    @transaction = Transaction.new()
    @transaction.date = Date.today
    if @transaction.save
      session[:xact_id] = @transaction.id
      redirect_to :controller => 'transaction_details', :action => 'details'
    end
  end
  
  def add
    @curr_xact = Transaction.find_by_id(session[:xact_id])
    @detail = @curr_xact.details.new()
    #@detail.transaction_id = @current_xact.id
    @prod = Product.find_by_product_name(params[:prod][:product_name])
    
    @detail.product_id = @prod.id
    @detail.update_attribute("quantity", params[:details])
    @qty = params[:details]
    @detail.update_attribute("price", (@prod.unit_price * @detail.quantity))
    
    #accumulate sum here
    
    if @detail.save
      redirect_to :action => "details"
    else
      @curr_xact.update_attribute("total", @sum)
      redirect_to :action => "transaction_end"
    end
  end
  
end
