class CashierController < ApplicationController
  def index
    redirect_to :controller => 'xact', :action=>'create'
  end
end
