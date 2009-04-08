class LoginController < ApplicationController

  def login
   @current_user = User.find_by_userid( params[:login] ) 
    if @current_user
      session[:u_id] = @current_user.id
      
      case @current_user.role
        when 'Manager'
          redirect_to :controller => 'manager', :action => 'index'
        when 'Cashier'
          redirect_to :controller => 'cashier', :action => 'index'
        when 'Administrator'
          redirect_to :controller => 'manager', :action => 'index'
        else
          render :action => 'login'
      end
    else
      flash[:error] = "Invalid username or password"
      render :action => 'login'
    end  
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :controller => 'login', :action => 'login'
  end
  
end
