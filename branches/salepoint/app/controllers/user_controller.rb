class UserController < ApplicationController
  def index
    if User.find_by_id(session[:u_id]).role == 'Administrator'
      @users = User.all
    else
      @users = User.find_all_by_branch_id(User.find_by_id(session[:u_id]).branch_id)
    end
  end
  
  def new
    @curr_user = User.find_by_id(session[:u_id])
  end
  
  def create
    @curr_user = User.find_by_id(session[:u_id])
    if User.find_by_userid(params[:user][:userid])==nil
      @user = User.new(params[:user])
      if @user.save
        if @curr_user.role == 'Manager'
          @user.update_attribute("branch_id", @curr_user.branch_id)
        else
          @user.update_attribute("branch_id", Branch.find_by_branch_name(params[:branch][:branch_name]).id)
        end
        flash[:notice] = "Successfully added new staff."
        redirect_to :action => 'index'
      else
        flash[:error] = "Error in input."
        redirect_to :action => 'new'
      end
    else
      flash[:error] = "Employee with User ID " + params[:user][:userid] + " already exists."
      redirect_to :action => 'new'
    end
  end
  
  def edit
    session[:id] = (@user = User.find_by_id(params[:id])).id
  end
  
  def update
    @user = User.find_by_id(session[:id])
    if @user.userid != params[:user][:userid] and User.find_by_userid(params[:user][:userid])!=nil
        flash[:error] = "Error: User ID already taken."
        redirect_to :action => 'index'
    else
      if @user.update_attributes(params[:user])
        @user.update_attribute("branch_id", Branch.find_by_branch_name(params[:branch][:branch_name]).id)
        flash[:notice] = "Successfully updated " + @user.first_name + " " + @user.last_name + "'s data."
        redirect_to :action => 'index'
      else
        flash[:error] = "Error in input."
        reidrect_to :action => 'index'
      end
    end
  end
  
  def destroy
    @user = User.find_by_id(params[:id])
	flash[:notice] = "Successfully deleted employee."
	@user.destroy
	redirect_to :action => 'index'
  end
  
end
