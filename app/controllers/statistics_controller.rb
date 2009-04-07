class StatisticsController < ApplicationController
  def index
    @products = Product.all
    @users = User.all
    @branches = Branch.all
    @curr_user = User.find_by_userid(session[:userid])
  end
  def userSales
    if(params[:id])
      @xacts = Xact.find_all_by_user_id(params[:id])
    end
  end
  def productSales
    if(params[:id])
      @xacts = Xact.find_by_sql ["select * from xacts x, xact_details xd where product_id = ? and xact_id = x.id" , params[:id]]
    end
  end
  def branchSales
    if(params[:id])
      @xacts = Xact.find_by_sql ["select * from xacts x, users u where u.branch_id = ? and x.user_id = u.id" , params[:id]]
    end
  end
end