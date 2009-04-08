class BranchController < ApplicationController
  def branch
    @branches = Branch.all
    @curr_user = User.find_by_id(session[:u_id])
  end
  
  def create
    @branch = Branch.new(params[:branch])
    if @branch.save
      redirect_to :action => 'branch'
    else
      redirect_to :action => 'new'
    end
  end
  
  def edit
    session[:b_id] = Branch.find_by_id(params[:id])
  end
  
  def update
    @branch = Branch.find_by_id(session[:b_id])
    if @branch.update_attributes(params[:id])
      flash[:notice] = "Successfully edited branch " + @branch.branch_name
	  redirect_to :action => 'branch'
	else
	  flash[:error] = "Error in input."
    end
  end
  
  def destroy
    @branch = Branch.find_by_id(params[:id])
    flash[:notice] = "Successfully deleted branch " + @branch.branch_name
    @branch.destroy
    redirect_to :action => 'branch'
  end
end
