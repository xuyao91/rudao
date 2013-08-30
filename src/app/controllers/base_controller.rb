#coding: utf-8
class BaseController < ApplicationController

  #before_filter :login_required, :except => [:login]

  require 'erb'
  include ERB::Util
  # generate csv file through different browers!
  #【引数】
  #【返値】
  #【注意】
  #【著作】by lh 2013-8-30
  def send_csv_by_brower_type(output, time = Time.now, format = "%Y%m%d%H%M%S")
    if time.is_a? Array
      time = [time.first.blank? ? "" : time.first.strftime(format).to_s, time.last.blank? ? "" : time.last.strftime(format).to_s].uniq.join("~")
    else
      time = time.strftime(format).to_s
    end
    case judage_brower_type(request.env["HTTP_USER_AGENT"])
      when "IE"
        send_data(output, :type => 'text/csv', :filename => "#{url_encode(@name)}_#{time}.csv")
      when "Firefox"
        send_data(output, :type => 'text/csv', :filename => "#{@name}_#{time}.csv")
      when "Safari"
        send_data(output, :type => 'text/csv', :filename => "#{@name}_#{time}.csv")
      else
        send_data(output, :type => 'text/csv', :filename => "#{url_encode(@name)}_#{time}.csv")
    end
  end

  # judge brower's type
  #【引数】
  #【返値】
  #【注意】
  #【著作】by by lh 2013-8-30
  def judage_brower_type(http_user_agent)
    return "Firefox" if http_user_agent.include?("Firefox")
    return "Safari" if http_user_agent.include?("Safari")
    return "IE" if http_user_agent.include?("MSIE")
    return "IE"
  end

end
