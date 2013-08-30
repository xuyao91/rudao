module ApplicationHelper
  def get_title(title = 0)
    hash = {'admin/genres' => {
                         'index' =>  "邀请码管理,b_sn3,sub03,sn3",
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
