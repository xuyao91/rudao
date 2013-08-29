class Admin::AdminSessionsController < Admin::BaseController
  before_filter :require_admin, :only => :destroy
  def index
    @admin_session = AdminSession.new
  end
  
  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to admin_admins_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @admin_session = AdminSession.find
    @admin_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to admin_login_path
  end
  
end
