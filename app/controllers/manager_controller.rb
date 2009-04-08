class ManagerController < ApplicationController
  def index
	@curr_user = User.find_by_id(session[:u_id])
	if @curr_user.role != 'Administrator'
	  @products = ProductBranch.find_all_by_branch_id(@curr_user.branch_id)
	else
	  @products = ProductBranch.all
	end
  end
end
