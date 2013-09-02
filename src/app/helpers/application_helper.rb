#coding: utf-8
module ApplicationHelper
  def get_title(title = 0)
    hash = {
        'admin/auths' => {
          'index' =>  "邀请码管理,b_sn3,sub03,sn3",#标题，id,class,模块
          'new'   => "新增邀请码,b_sn3,sub03,sn3"
        },
        'admin/brands' => {
            'add'     => "品牌管理,b_sn1,sub01,sn1",
            'create' => "品牌管理,b_sn1,sub01,sn1"
        },
        'admin/admin_sessions' => {
          'new' => ""
          
        }
    }
    if hash.keys.to_a.include?(params[:controller]) && hash[params[:controller]].keys.to_a.include?(params[:action])
      hash[params[:controller]][params[:action]].to_s.split(",")
    else
      #hash["admin/branches"]["list"].to_s.split(",")
      return []
    end
  end
end
