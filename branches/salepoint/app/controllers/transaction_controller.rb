class TransactionController < ApplicationController
  def transaction
    @transactions = Transaction.all
  end
  
  def create
    @transaction = Transaction.new()
    @transaction.date = Date.today
    if @transaction.save
      redirect_to :controller => 'transaction_details', :action => 'details'
    end
  end
  
end
