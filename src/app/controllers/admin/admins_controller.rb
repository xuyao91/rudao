class Admin::AdminsController < Admin::BaseController
  

  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:notice] = "Registration successful."
      redirect_to admin_auths_path
    else
      render :action => 'new'
    end
  end
  
  
end
