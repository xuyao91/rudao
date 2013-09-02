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
        'admin/admins' => {
          'index' => "管理员一览,b_sn4,sub04,sn4",
          'new' => "新增管理员,b_sn4,sub04,sn4",
          'edit' => "编辑管理员,b_sn4,sub04,sn4",
          'create' => "新增管理员,b_sn4,sub04,sn4"
          
        },
        
    }
    if hash.keys.to_a.include?(params[:controller]) && hash[params[:controller]].keys.to_a.include?(params[:action])
      hash[params[:controller]][params[:action]].to_s.split(",")
    else
      #hash["admin/branches"]["list"].to_s.split(",")
      return []
    end
  end
end
