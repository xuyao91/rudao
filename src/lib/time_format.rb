module TimeFormat
  def json_decode(str)
    ActiveSupport::JSON.decode(str)
  end
  
  def format_width(width)
    width.blank? ? "200px" : width.to_s.gsub(/\D/,"") + "px"
  end
  
   def urlencode(str)
     str.gsub(/[^a-zA-Z0-9_\.\-]/n) {|s| sprintf('%%%02x', s[0]) }
   end

  
end
class Object
  def rpc_as_(key, options = {})
    unless key.blank?
#      text = I18n.translate "#{key}", {:scope => [:active_scaffold], :default => key.is_a?(String) ? key : key.to_s.titleize}.merge(options)
      # text = nil if text.include?('translation missing:')
    end
    text ||= key 
    text
  end
  
  alias_method :as__without_jp, :rpc_as_
  def as__with_jp(*args)
    pars = args.dup
    fmt = pars.shift
    text = XmlUtil::ERR_CODE[fmt]
    if text
      unless pars.empty?       
        pars[0].each_pair do|key,value|
          text = text.gsub(/\{\{#{key}\}\}/,value.to_s + ": ")
        end
      end
      return text
     end      
    return as__without_jp(*args)
  end

  alias_method :rpc_as_, :as__with_jp
  
  
end
class Hash
  def to_struct
    h = Struct.new(*self.keys)
    h.new(*self.values)
  end
end
class Date
  def saturday?
    strftime("%a").eql?("Sat") ? true : false
  end
  
  def sunday?
    strftime("%a").eql?("Sun") ? true : false
  end

  def self.get_former_date(options = {:type => 'month', :number => 6, :current_time => Time.now })
    date = []
    current_time = options[:current_time] rescue Time.now.to_date
    date << current_time
    1.upto(options[:number].to_i) do |i|
      d = current_time - i.try(options[:type].to_sym) rescue ''
      date << d if d
    end    
    date
  end
    
  
end
class DateTime
      # Returns a JSON string representing the datetime. If ActiveSupport.use_standard_json_time_format is set to true, the
      # ISO 8601 format is used.
      #
      # ==== Examples
      #
      #   # With ActiveSupport.use_standard_json_time_format = true
      #   DateTime.civil(2005,2,1,15,15,10).to_json
      #   # => "2005-02-01T15:15:10+00:00"
      #
      #   # With ActiveSupport.use_standard_json_time_format = false
      #   DateTime.civil(2005,2,1,15,15,10).to_json
      #   # => "2005/02/01 15:15:10 +0000"
      def to_json(options = nil)
        if ActiveSupport.use_standard_json_time_format
          xmlschema.inspect
        else
          strftime('"%Y/%m/%d %H:%M:%S"')
#          strftime('"%Y/%m/%d %H:%M:%S %z"')
        end
      end
    end
    
    class Time
      # Returns a JSON string representing the time. If ActiveSupport.use_standard_json_time_format is set to true, the
      # ISO 8601 format is used.
      #
      # ==== Examples
      #
      #   # With ActiveSupport.use_standard_json_time_format = true
      #   Time.utc(2005,2,1,15,15,10).to_json
      #   # => "2005-02-01T15:15:10Z"
      #
      #   # With ActiveSupport.use_standard_json_time_format = false
      #   Time.utc(2005,2,1,15,15,10).to_json
      #   # => "2005/02/01 15:15:10 +0000"
      def to_json(options = nil)
        if ActiveSupport.use_standard_json_time_format
          xmlschema.inspect
        else
          strftime('"%Y-%m-%d %H:%M:%S"')
#          %("#{strftime("%Y/%m/%d %H:%M:%S")} #{formatted_offset(false)}")
        end
      end
    end
    
#有用 勿删 转换为 unixtime
#DateTime.strptime('15/May/2007:22:48:00', '%d/%b/%Y:%H:%M:%S').strftime('%s').to_i