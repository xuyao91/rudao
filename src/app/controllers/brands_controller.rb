#coding: utf-8
class BrandsController < BaseController
  def add
    conn = Brand.get_conditions params
    @brands = Brand.paginate(:conditions => conn,:page => params[:page] , :per_page => APP_CONFIG[:per_page], :order =>"brands.updated_at DESC")
  end

  def create
    pp '-----------------'
    pp params[:name]
    brand = Brand.new(:name => params[:name])
    if brand.valid?
       pp '11111111111111'
       brand.save!
       redirect_to  :action => "add"
    else
       conn = Brand.get_conditions params
       @brands = Brand.paginate(:conditions => conn,:page => params[:page] , :per_page => APP_CONFIG[:per_page], :order =>"brands.updated_at DESC")
       render :action => "add"
    end
  end
end
