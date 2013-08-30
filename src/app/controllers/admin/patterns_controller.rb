#coding: utf-8
class Admin::PatternsController < Admin::BaseController

  # 品牌型号添加和一览
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
   def add
     @brands = Brand.all
     conn = Pattern.get_conditions params

   end


end
