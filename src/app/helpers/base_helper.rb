#coding: utf-8
module BaseHelper

  #get page title
  #【引数】
  #【返値】
  #【注意】
  #【著作】 by lh 2013-8-30
  def get_page_title
    _nas = normal_action
    if _nas[params[:controller].to_s].present? && _nas[params[:controller].to_s][params[:action].to_sym].present?
      return _nas[params[:controller].to_s][params[:action].to_sym]
    else
      return "Rudao"
    end
  end

  #get title
  #【引数】
  #【返値】
  #【注意】
  #【著作】by lh 2013-8-30
  def normal_action
    {
        "admin/admins" => {
            :new => "添加用户"
        },
        "admin/brands" => {
            :add => "品牌一览",
            :create => "品牌一览"
        },
        "users" => {
            :new => "Rudao"
        }

    }
  end
end
