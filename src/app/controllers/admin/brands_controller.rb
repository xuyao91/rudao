#coding: utf-8
class Admin::BrandsController < Admin::BaseController
  before_filter :convert_paranms
  # 品牌添加和一栏页面
  #【引数】
  #【返値】conn
  #【注意】
  #【著作】 by lh 2013-8-30
  def add
    conn = Brand.get_conditions params
    pp conn
    @brands = Brand.paginate(:conditions => conn, :page => params[:page] , :per_page => APP_CONFIG[:per_page], :order =>"brands.updated_at DESC")
  end

  # 品牌添加后台处理
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def create
    @brand = Brand.new(:name => params[:name])

    pp '--------------------------------------------'
    pp params
    pp @brand
    if @brand.valid?
      @brand.save!
      redirect_to  :action => "add"
    else
      pp '----------------------2'
      pp @brand.errors
      conn = Brand.get_conditions params
      @brands = Brand.paginate(:conditions => conn,:page => params[:page] , :per_page => APP_CONFIG[:per_page], :order =>"brands.updated_at DESC")
      render :action => "add"
    end

  end

  # 删除品牌
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def destroy
    params[:id].present? or (
      redirect_to  :controller => "admin/brands", :action => "add"
    )
    brand = Brand.where(:id => params[:id]).first
    brand.present? or (
      redirect_to  :controller => "admin/brands", :action => "add"
    )
    brand.delete
    redirect_to  :controller => "admin/brands", :action => "add"
  end

  # 显示编辑品牌文本框
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def show_edit
    params[:id].present? or (
      render :text => ""
    )
    brand = Brand.where(:id => params[:id]).first
    brand.present? or (
      render :text => ""
    )
    render :partial => 'edit', :locals => {:brand => brand}
  end

  # 取消编辑品牌文本框
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def cancel_edit
    params[:id].present? or (
      render :text => ""
    )
    brand = Brand.where(:id => params[:id]).first
    brand.present? or (
      render :text => ""
    )
    render :partial => 'detail', :locals => {:brand => brand}
  end
  # 编辑品牌
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def edit
    params[:id].present? or (
     render :text => ""
    )
    brand = Brand.where(:id => params[:id]).first
    brand.present? or (
      render :text => ""
    )
    brand.update_attribute("name", params[:name])
    render :partial => 'detail', :locals => {:brand => brand}
  end

  # 参数转换
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def  convert_paranms
    params[:name_1].blank? or (
      params[:name] = params[:name_1]
    )
    params[:name_2].blank? or (
      params[:name] = params[:name_2]
    )
  end
end
