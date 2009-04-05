class TransactionDetailsController < ApplicationController
  @sum = 0
  def create
    @current_xact = Transaction.find_by_id(1)
    @detail = @current_xact.details.new()
    @detail.transaction_id = @current_xact.id
    @prod = Product.find_by_id(params[:prod])
    
    @detail.product_id = @prod.id
    @detail.update_attribute("quantity", params[:details])
    @qty = params[:details]
    @detail.update_attribute("price", (@prod.unit_price * @qty))
    
    @sum = @sum + @detail.price
    
    if @detail.save
      redirect_to :action => "details"
    else
      @current_xact.update_attribute("total", @sum)
      redirect_to :action => "transaction_end"
    end
  end
end
