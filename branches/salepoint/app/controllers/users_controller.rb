class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def view
    @users = User.all
  end
  
  def add
    @user_add = User.new()
  end
  
  def edit_choose
    @users = User.all
    @branch = Branch.all
  end
  
  def delete_choose
    @users = User.all
  end

end
