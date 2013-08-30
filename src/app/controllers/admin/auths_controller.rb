#coding: utf-8
class Admin::AuthsController < ApplicationController
  
  def index
    conn = Auth.get_conditions params
    @auths = Auth.paginate(:conditions=>conn,:page => params[:page] || 1, :per_page => APP_CONFIG[:per_page], :order => 'id DESC')
  end
  
  def show
    
  end

  def edit
    
  end
  
  def update
    
  end  
end
