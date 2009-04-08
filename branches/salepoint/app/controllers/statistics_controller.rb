class StatisticsController < ApplicationController
  def index
    @curr_user = User.find_by_id(session[:u_id])
    if @curr_user.role != 'Administrator'
	  @products = ProductBranch.find_all_by_branch_id(@curr_user.branch_id)
	else
      @products = Product.all
	end
    @users = User.all
    @branches = Branch.all
    @xacts = Xact.all
    @pbranch = ProductBranch.all
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