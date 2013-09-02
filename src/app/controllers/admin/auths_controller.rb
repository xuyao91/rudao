#coding: utf-8
class Admin::AuthsController < Admin::BaseController
  
  before_filter :find_auth, :only=>[:destroy]
  
  def index
    pp "*****************-",current_admin
    conn = Auth.get_conditions params
    @auths = Auth.paginate(:conditions=>conn,:page => params[:page] || 1, :per_page => APP_CONFIG[:per_page], :order => 'id DESC')
  end
  
  def show
    
  end
  
  def create
    count = 1
    sum = params[:count].to_i
    flag = true
    while count <=sum do
       code = UUIDTools::UUID.random_create.to_s[0,21].gsub('-','')
       @auth = Auth.find_by_code(code)
       if @auth.present?
         next
       else
         Auth.transaction do
           begin 
             @auth = Auth.create(:code => code, :usable=> 1)
               count += 1
           rescue Exception => e
              raise ActiveRecord::Rollback
              flag = false
              break
           end
         end
      end
    end
    if flag
      flash[:notice] = "数据生成成功"
    else
      flash[:error] = "数据生成出错，操作终止"
    end
    redirect_to admin_auths_path
  end

  def edit
    
  end
  
  def update
    
  end  
  
  def destroy
    if @auth.destroy
      flash[:notice] = "数据删除成功"
    else
      flash[:notice] = "数据出错"
    end
    redirect_to admin_auths_path
  end
  
  private
  
  def find_auth
    @auth = Auth.find_by_id(params[:id])
    if @auth.blank?
      flash[:notice] = "数据出错"
      redirect_to admin_auths_path
    end
  end
end
