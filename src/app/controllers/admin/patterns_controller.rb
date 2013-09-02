#coding: utf-8
class Admin::PatternsController < Admin::BaseController

  # 品牌型号添加和一览
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
   def index
     @brands = Brand.all
     conn, include = Pattern.get_conditions params
     @patterns = Pattern.paginate(:conditions => conn, :include => include, :page => params[:page] , :per_page => APP_CONFIG[:per_page], :order =>"patterns.updated_at DESC")
   end


end
