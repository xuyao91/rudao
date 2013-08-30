class UsersController < ApplicationController
  
  def index
    
  end
  
  def show
    
  end
  
  def create
    pp "***************************",params
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration successful."
      redirect_to admin_admins_path
    else
      render :action => 'new'
    end
  end
 
 def new
   pp "--------------------------------------"
 end
 
  def edit
    
  end
end
