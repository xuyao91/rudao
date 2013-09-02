class Admin::AdminsController < Admin::BaseController
  

  def index
    conn = Admin.get_conditions params
    @admins = Admin.paginate(:conditions=>conn, :page => params[:page] || 1, :per_page => APP_CONFIG[:per_page], :order => 'id DESC')
  end

  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      
      flash[:notice] = I18n.t(:registration_successful)
      redirect_to admin_auths_path
    else
      render :action => 'new'
    end
  end
  
  
end
