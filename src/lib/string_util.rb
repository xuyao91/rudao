# coding: utf-8
require 'nkf'

class Float

  def roundf(places)
    temp = self.to_s.length
    sprintf("%#{temp}.#{places}f",self).to_f
  end

end


class Fixnum
  def time
    hour = self/3600
    minute = self%3600/60
    seconds = self%3600%60
    "#{hour}:#{sprintf('%02d', minute)}:#{sprintf('%02d',seconds)}"
  end
end

#add by wll for nil.is_tv? error
class NilClass
  def is_tv?
    return false
  end
end

class Range
  #【引数】
  #【返値】
  #【注意】
  #【著作】by mrq 20110309
  def rand 
    return first if exclude_end? && last == first
    Kernel::rand(last - first + (exclude_end? ? 0 : 1)) + first
  end
end

class String

  # for card
  #【引数】
  #【返値】
  #【注意】
  #【著作】by zyc 20110727
  def lshield(num = 12)
    if self.length > num
      return '*'*12 + self[num..self.length-1]
    else
      return '*' * self.length
    end
  end

  #for money unit
  def monetary_unit
    return self << ' 円'
  end

  #for epice
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wt 20100304
  def str_to_asc(asc = 7)
    self.gsub(/\r\n|\n/, asc.chr)
  end


  
  #for epice
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wt 20100304
  def asc_to_str(asc = 7)
    self.gsub(asc.chr, "\r\n")
  end
  
  #for epice
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wt 20100304
  def asc_to_html(asc = 7)
    self.gsub(asc.chr, "<br/>")
  end
  
  #for epice
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wt 20100304
  def str_to_html
    self.gsub(/\r\n|\n/, "<br/>")
  end
  
  def part_email
    "******@#{self.split('@').last}" unless self.blank?
  end
  
  def increase_str(str = "UID")
    return nil if self.blank?
    if self =~ /^#{str}/
      self
    else
      "#{str}#{self}"
    end
  end
  
  def blank_show_default(dft='--')
    self.blank? ? dft : self
  end
  
  def mbsubstr1(*range)
    split(//)[*range].join("")
  end
  
  def intercept(n, truncate_string = '…')
    self.jsize < n.to_i ? self : [self.scan(/./)[0, n].join, truncate_string].join
  end

 
  
  
  #按照传进来的字符串返回该字符的个数（全角算1个 半角0.5个）
  #该方法只针对tv部分
  #【引数】
  #【返値】返回字符串的行数（TV页面）
  #【注意】
  #【著作】by gxw 20100831
  def recount_by_byte
    tmp_size = 0
    
    self.gsub(/\r|\n/, '').split(//).each do |char|
      if(char.size == 1) #半角字符
        tmp_size += 0.6
      else
        tmp_size += 1
      end
    end
    tmp_size  
  end


  #slice string by byte(一个全角字符大小当两个半角来算)
  #该方法只针对tv部分，调用时需小心
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wll 20100608
  def intercept_by_byte(n, truncate_string = '…')
    n = n.to_i
    tmp_size = 0
    tmp_str = ''
    
    # 20100712 fujikazu edited
    # self.chars.to_a.each do |char|
    self.split(//).each do |char|
      if(char.size == 1) #半角字符
        tmp_size += 0.5
      else
        tmp_size += 1
      end
      tmp_str += char if(tmp_size <= n)
    end
    tmp_str << truncate_string if tmp_str.size < self.size
    tmp_str
    #    if self.size <= n
    #      return self
    #    else
    #      tmp = ''
    #      self.chars.to_a.each{|t| tmp += t if (tmp + t).size <= n}
    #      return [tmp, truncate_string].join
    #    end
  end 

  #把字符串截取成max_lines, 每行n个全角汉字
  #该方法只针对tv部分，调用时需小心
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wll 20100714
  def intercept_with_lines(n, max_lines, truncate_string = '…')
    n = n.to_i
    lines = 0
    result_lines = []
    ary = self.split(/\r?\n/)
    #insert <br> in every line if line.size > n*3
    ary[0, max_lines].to_a.each do |line|
      line = line.to_s
      break if lines >= max_lines
      tmp_line = ''
      insert_to = 0  #insert <br/> index
      #insert <br/> every n*3 bytes in line
      if(line.size / (n*3) > 1)
        (line.size / (n * 3)).to_i.downto(1).each do |i|
          lines += 1
          insert_to = line.intercept_by_byte(n*i, '').size
          line = line.insert(insert_to, '<br/>') if line.size > n*3
        end
      else
        lines += 1
      end
      result_lines << line
    end
    result_lines = result_lines.join('<br/>').split('<br/>')
    all_lines = result_lines.size
    result_lines = result_lines[0, max_lines] if result_lines.size > max_lines
    last_line = result_lines.last
    #add the truncate_string to the last line if the text is splited
    if all_lines > max_lines
      if last_line.size < (n - 1) * 3
        last_line += truncate_string
      else
        last_line = last_line.intercept_by_byte(n-1, truncate_string)
      end
    end
    result_lines[result_lines.size - 1] = last_line
    return result_lines.join('<br/>')
  end
  
  def is_int?
    #    self.match /^[-+]?\d+$/
    self.match /^\d+$/
    #    self.match /^\d+$/
  end
  
  def is_number?
    self.match /^[-+ ]*?\d+$/
  end

  def is_date?
    Date.parse(self).present? rescue false
  end
  
  def is_time?
    is_date? && Time.parse(self).present? rescue false
  end

  #把字符串截取成max_lines, 每行n个全角汉字
  #该方法只针对tv部分，调用时需小心
  #【引数】
  #【返値】
  #【注意】
  #【著作】by wll 20100714

  def utf8_to_gb2321
    encode_convert(self, "gb2321", "UTF-8")
  end

  def gb2321_to_utf8
    encode_convert(self, "UTF-8", "gb2321")
  end

  def utf8_to_utf16
    encode_convert(self, "UTF-16LE", "UTF-8")
  end

  def utf8?
    begin
      utf8_arr = self.unpack('U*')
      true if utf8_arr && utf8_arr.size > 0
    rescue
      false
    end
  end

  private
  def encode_convert(s, to, from)
    require 'iconv'
    begin
      converter = Iconv.new(to, from)
      converter.iconv(s)
    rescue
      s
    end
  end

end
class TrueClass
  def label
    '○'
  end
end
class FalseClass
  def label
    '×'
  end
end
class Array
  #后台分页显示总记录
  def page_entries_info
    if self.blank? || self.total_entries == 0
      ""
    else
      "検索結果：#{self.total_entries} 件が見つかりました。"
    end
  end

  #【引数】
  #【返値】
  #【注意】
  #【著作】 zyc 20110718
  # 判断arr是否是self的子集
  def subset_of_it?(arr)
    arr.each do |item|
      return true if self.include?(item)
    end
    return false
  end
  
end
module StringUtil

  # sort by あいうえお
  #【引数】
  #【返値】
  #【注意】
  #【著作】by lb 20120203
  def sort_by_jp(ary)
    origin = "ａ-ｚＡ-Ｚァ-ン０-９ぁぃぅぇぉがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゃゅょっゎァィゥェォガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポャュョッヮ"
    normalize = "a-zA-Zぁ-ん0-9あいうえおかきくけこさしすせそたちつてとはひふへほはひふへほやゆよつわあいうえおかきくけこさしすせそたちつてとはひふへほはひふへほやゆよつわ"
    ary.sort_by {|fd| fd.name.to_s.tr(origin, normalize)}
  end

  # メッセージの宛先選択　ソート. sort by あいうえお
  #【引数】
  #【返値】
  #【注意】
  #【著作】by lb 20120203
  def mess_username_sort_by_jp(ary)
    #origin = "ａ-ｚＡ-Ｚァ-ン０-９ぁぃぅぇぉがぎぐげござじずぜぞだぢづでどばびぶべぼぱぴぷぺぽゃゅょっゎァィゥェォガギグゲゴザジズゼゾダヂヅデドバビブベボパピプペポャュョッヮ"
    #normalize = "a-zA-Zぁ-ん0-9あいうえおかきくけこさしすせそたちつてとはひふへほはひふへほやゆよつわあいうえおかきくけこさしすせそたちつてとはひふへほはひふへほやゆよつわ"
    #ary.sort_by {|pur| pur.user_name_from_sql.to_s.tr(origin, normalize) unless pur.user_name_from_sql.blank?}
    
    ary.sort{|a,b|a.first_name_py <=> b.first_name_py}
    
  end

  # change the specice word to \+word in the sql conditions
  #【引数】
  #【返値】 string
  #【注意】
  #【著作】by lb 20110531
  def sql_escape_word(wd)
    wd.to_s.gsub(/\%/, '\%').to_s.gsub(/\^/, '\^').to_s.gsub(/\_/, '\_')
  end

  def is_win?
    begin
      require('Win32API.so')
      return true
    rescue Exception
      return false
    end
  end
  
  #convert boolean into int
  def bln_to_int(bln)
    bln ? 1 : 0
  end
  
  # メッセージ表示系 
  # 引数 : model_name => 目的語(モデルの日本語名)
  #        msg_tmpl   => 述語(操作)

  # 替换app_config里面的%{}
  #【引数】
  #【返値】 string
  #【注意】
  #【著作】by lb 20110531
  def replace_spec(old_val, host=nil)
    #    old = old_val
    #    new_str = old.gsub(/%\{(.*)\}/) do |x|
    #      b = $1.to_s.gsub(/^:/, '')
    #      k_sym = b.to_sym
    #      if k_sym == :liveclass_host2
    #        host
    #      elsif LIVE_CONFIG.key?(k_sym)
    #        LIVE_CONFIG[k_sym]
    #      end
    #    end
    if host == '127.0.0.1' || host == 'localhost'
      "http://#{host}:3000/#{old_val}"
    else
      "http://#{host}/#{old_val}"
    end
  end

  #【引数】
  #【返値】 string
  #【注意】
  #【著作】by lb 20110531
  def replace_spec_root(old_val, host=nil)
    "#{RAILS_ROOT}/#{old_val}"
  end

  #是否是手机邮箱
  #【引数】
  #【返値】
  #【注意】
  #【著作】by yak 20100107
  def mobile_mail?(str)
    mobile_regexp_first = /([^@\s]+)@(docomo|softbank|disney|ezweb|[dhtkrsnqc]\.vodafone|pdx|d[kij]\.pdx|wm\.pdx|em\.nttpnet|pipopa|.*sky\.tu-ka|.*sky\.tk[ck]|jp-[dhtkrsnqc]|t[2-9]\.ezweb)\.ne\.jp$/i
    mobile_regexp_second = /([^@\s]+)@(bandai\.jp|i\.softbank\.jp|willcom\.com)$/i
    str.match(mobile_regexp_first) || str.match(mobile_regexp_second)
  end
  
  def skip_all_blank_space
    self.gsub(/ |　/, '')
  end
  
  # by mrq 20100728
  def escape_js(str)
    if str.class == String
      str.gsub!(/(<script[^>]*>)(.*?)(<\/script>)/) do |match|
        $2
      end
    end
    str
  end
  
  # 2009/11/22 - 2010/11/22
  def date_diff(date1, date2)
    date1 = date1.to_date
    date2 = date2.to_date
    year_diff = 1
    month_diff = 0
    if (date1.year - date2.year) >= 1
      year_diff = date1.year - date2.year
    else 
      return date1.month - date2.month
    end
    month_diff += 12 - date2.month
    month_diff += (year_diff-1)*12 + date1.month
    month_diff
  end
  
  def format_unit(str, unit)
    unless str.blank?
      str.to_s + unit.to_s
    end
  end

  def format_price(value)
    return nil if value.blank?
    value.to_i
  end
  
  def msg(model_name, msg_tmpl)
    sprintf(msg_tmpl, model_name)
  end
  
  def xor(str, default_str)
    str.blank? ? default_str : str
  end
  
  def number_with_precision(number, precision=3)  
    "%01.#{precision}f" % ((Float(number)*(10**precision)).round.to_f/10**precision)  
  rescue  
    number
  end 
  
  def format_rate(number, precision=3)  
    number = number_with_precision(number, precision)  
    if number.class == Float
      #number.nan? ? 0 : (number.infinite? ? -1 : number)    
      number.nan? ? 0 : (number.infinite? ? 0 : number)
    else
      number.to_f
    end
  end
  
  def format_review(review)
    return nil if review.blank?
    review.to_f > 0 ? review : nil
  end
  
  def log_per_time(type)
    #    arr = [
    #      ["weekly", 9],
    #      ["monthly", 33],
    #      ["yearly", 13]
    #    ]
    return case type
    when "weekly"
      (1..9).to_a.inject([]) do |arr, i|
        arr.push(Day.to_day - i.days)
      end
    when "monthly"
      []
    when "yearly"
      []
    else
      []
    end
  end
  
  #by mrq 20100316
  def pre_img
    "<img width='12' height='12' align='absmiddle' alt='' src='/cms_images/mobile/btn_04.gif' />"
  end
  
  #by mrq 20100316
  def next_img
    "<img width='12' height='12' align='absmiddle' alt='' src='/cms_images/mobile/btn_06.gif' />"
  end
  
  def red_star
    "<span class='attention'>★</span>"
  end
  
  def red
    "<span class='redstar'>※</span>"
  end
  
  def red_label
    "<font color='#FF0000'>※</font>"
  end
  
  #数字を3桁区切りで出力する。 
  def commify(price)
    return price.to_s.gsub(/(\d)(?=\d{3}+$)/, '\\1,')
  end
  
  # Time 系
  
  # Timeを与えて、yyyy年mm月dd日 HH時:MM分の文字列を得る
  def human_time(time)
    unless time.blank?
      time.strftime('%Y年%m月%d日 %H:%M')
    else
      '--'
    end
  end
  
  # Timeを与えて、yyyy年mm月dd日 の文字列を得る
  def human_time_short(time)
    unless time.blank?
      time.strftime('%Y年%m月%d日 ')
    else
      '--'
    end
  end
 
  def date_time_name
    @name = to_n(Time.now.year.to_s,4).to_s + to_n(Time.now.month.to_s,2).to_s + to_n(Time.now.day.to_s,2).to_s + to_n(Time.now.hour.to_s,2).to_s  + to_n(Time.now.min.to_s,2).to_s + to_n(Time.now.sec.to_s,2).to_s
  end


  
  #  record id and 2 sec
  def short_number(prenumber,n) 
    @str =  prenumber.to_s + to_n(Time.now.sec.to_s,2).to_s
    return to_n(@str,n)
  end

  #bugNo:27447
  #edit by ll 20110112
  def short_number_uuid(prenumber='01', n=10)
    uuid_class = (UUIDTools::UUID rescue UUID)
    uuid_class.random_create().to_s
  end
  
  def to_n(ori_number,n)
    new_number = ori_number.to_i.to_s
    if ori_number.to_s.length < n
      zero_need = n - ori_number.to_s.length
      for i in 1..zero_need
        new_number = "0" + new_number.to_s
      end 
      return new_number
    else
      return ori_number
    end
  end
  # String 
  
  # Stringを与えて、\nを<br /> に置換したHTML文字列を得る
  def to_br(str)
    return str if str.blank?
    pstr = str.to_s.dup
    pstr.to_s.gsub!(/\r?\n/, '<br/>') unless pstr.blank?
    pstr.to_s.gsub!(' ', '&nbsp;') unless pstr.blank?
    return pstr
  end
  
  #发邮件时用
  def email_str(str)
    str.to_s.split("\n").collect{|s| add_n(s)}.join("\n")
  end
  
  def add_n(str)
    res = []
    while str.present?
      tmp = limittext(str, 400)
      str = str.sub(tmp,"")
      res << tmp
    end
    res.join("\n")
  end
  
  def limittext(text, length, tail=nil)
    if text
      if (text.length <= text.mbsubstr1(0..length-1).length)
        return text
      else
        return text.mbsubstr1(0..length-1) + tail.to_s
      end
    end
  end
  
  # 秒数を hh:mm:ss にする。
  def sec_to_hms(sec)
    unless sec.blank? || ! sec.is_a?(Integer)
      hour = sprintf('%01d',(sec / 3600).floor)
      minute = sprintf('%02d', (sec / 60).floor % 60)
      second = sprintf('%02d',sec % 60)
      "#{hour}:#{minute}:#{second}"
    else
      '未入力'
    end
  end
  
  # ActiveRecordエラーを表示する
  # 引数 : ActiveRecord::Errors
  def show_ar_errors(errors)
    errors_ary = []
    errors.each_full do |msg| 
      errors_ary << '・' + msg
    end
    errors_ary.join('<br />')
  end
  
  # UTF8に変換した文字列を返す
  # 引数 : 元文字コード(省略した場合は自動)
  def to_utf8(str, from_code=nil)
    #validate_from_code_opt(from_code) if from_code
    NKF.nkf("-wS", str)
  end
  
  # Sjift_JISに変換した文字列を返す
  # 引数 : 元文字コード(省略した場合は自動)
  def to_sjis(str, from_code=nil)
    #validate_from_code_opt(from_code) if from_code
    NKF.nkf("-sW", str)
  end
  
  # ファイルサイズを見やすいフォーマットで出力
  # 引数 : ファイルサイズ(byte単位)
  def human_filesize(filesize)
    return "0 Bytes" if filesize.blank?
    if filesize < 1024 # 1KB未満
      unit = "Bytes"
      power = 0
    elsif filesize < 1024 ** 2 # 1MB未満
      unit = "KB"
      power = 1
    elsif filesize < 1024 ** 3 # 1GB未満
      unit = "MB"
      power = 2
    else # 1GB以上
      unit = "GB"
      power = 3
    end
    sprintf("%.2f %s",filesize.to_f / 1024.0 ** power.to_f, unit)
  end
  
  # 全角を半角に変換
  def zen2han(str)
    return if str.nil?
    han = str.tr("Ａ-Ｚａ-ｚ０-９", "A-Za-z0-9")
    han.tr!('＆％（）！　．，＋－', '&%()! .,+-')
    
    dakuon     = 'ガギグゲゴザジズゼゾダヂヅデドバビブベボヴ'
    daku_clear = 'カキクケコサシスセソタチツテトハヒフヘホウ'
    handakuon     = 'パピプペポ'
    handaku_clear = 'ハヒフヘホ'
    han.gsub!(/[#{dakuon}]/) {|c| c + 'ﾞ'}
    han.gsub!(/[#{handakuon}]/) {|c| c + 'ﾟ'}
    han.tr!(dakuon + handakuon, daku_clear + handaku_clear)
    
    zenkaku = '。「」、・ァィゥェォャュョッーアイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲン゛゜ヵヶヰヱヮ'
    hankaku = '｡｢｣､.ｧｨｩｪｫｬｭｮｯｰｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝﾞﾟｶｹｲｴﾜ'
    han.tr(zenkaku, hankaku) || han
  end
  
  # 半角に全角を変換
  
  # 半角文字を全角に変換するための関数。カナ以外の半角英数字および記号も
  # 全角に変換するかどうかはオプションで指定。
  def han2zen(text)
    text = text.tr("A-Za-z0-9", "Ａ-Ｚａ-ｚ０-９")
    text.tr!('&%()! .,+-', '＆％（）！　．，＋－')
    zen = %w(ガ ギ グ ゲ ゴ ザ ジ ズ ゼ ゾ ダ ヂ ヅ デ ド バ ビ ブ ベ ボ パ ピ プ ペ ポ ヴ ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ ハ ヒ フ ヘ ホ マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン ャ ュ ョ ァ ィ ゥ ェ ォ ッ ゛ ゜ ー ).freeze
    han = %w(ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ｳﾞ ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ｦ ﾝ ｬ ｭ ｮ ｧ ｨ ｩ ｪ ｫ ｯ ﾞ ﾟ ｰ).freeze
    han.each_with_index do |int, i|
      text.gsub!(int, zen[i])
    end
    text
  end         
  def translate(str)
    if str.blank?
      ''
    else 
      I18n.t(str)
    end
  end
  
  # by mrq 2011-04-11
  def date_format(date) 
    unless date.blank?
      date.to_date.strftime('%Y-%m-01') rescue '--'
    else
      '--'
    end
  end

  # 04:14
  def date_format_hs(date)
    unless date.blank?
      date.to_date.strftime('%m:%d') rescue '--'
    else
      '--'
    end
  end

  # 2011-04-14
  def date_format_full(date) 
    unless date.blank?
      date.to_date.strftime('%Y-%m-%d') rescue '--'
    else
      '--'
    end
  end

  def date_format_full_unline(date)
    unless date.blank?
      date.to_date.strftime('%Y-%m-%d') rescue ' '
    else
      ''
    end
  end

  def date_format_s(date)
    unless date.blank?
      date.to_date.strftime('%m/%d') rescue '--'
    else
      '--'
    end
  end
  
  def date_format_l(date)
    unless date.blank?
      date.to_date.strftime('%Y/%m/%d') rescue '--'
    else
      '--'
    end
  end
  
  #'87/2/3'
  def date_time_format_i(date)
    unless date.blank?
      date.to_date.strftime('%Y/%m/%d') rescue '--'
    else
      '--'
    end
  end
  
  def date_time_format_m_d(date)
    unless date.blank?
      date.to_date.strftime('%m/%d') rescue '--'
    else
      '--'
    end
  end
  #'87/2/3 11:11:11'
  def date_time_format_l(time)
    unless time.blank?
      time.strftime("%Y-%m-%d %H:%M:%S") rescue '--'
    else
      '--'
    end
  end
  #2/10 11:23
  def datetime_format_md(time)
    unless time.blank?
      time.strftime("%m/%d %H:%M") rescue '--'
    else
      '--'
    end
  end
  
  #2010年2月
  def datetime_format_ym(time)
    unless time.blank?
      time.to_date.strftime("%Y年%m月") rescue '--'
    else
      '--'
    end
  end
  
  def time_format(time)
    unless time.blank?
      time.strftime("%Y%m%d") rescue '--'
    else
      '--'
    end
  end
  
  #2010/07
  def time_format_format_ym(time)
    unless time.blank?
      time.strftime("%Y/%m") rescue '--'
    else
      '--'
    end
  end
  
  #by ll 20100803
  def date_format_dot(time)
    unless time.blank?
      time.strftime("%Y.%m.%d") rescue '--'
    end
  end

  # get the live status time
  #【引数】
  #【返数】
  #【注意】
  #【著作】dxy 20110719
  def time_full
  return Time.now.strftime("%Y-%m-%d%H:%M")
  end

  def today_date
  return Time.now.strftime("%Y-%m-%d")
  end

  def now_time
  return Time.now.strftime("%H:%M")
  end



  # by dxy 20110630
  def in_time(date)
    now_time = Time.now.strftime("%Y-%m-%d %H:%M")
    return  now_time < date
  end

  # get day of the week
  def day_week(date)
    day_week = "--"
    unless date.blank?
      case date.strftime("%A")
      when "Monday"
        day_week = "月"
      when "Tuesday"
        day_week = "火"
      when "Wednesday"
        day_week = "水"
      when "Thursday"
        day_week = "木"
      when "Friday"
        day_week = "金"
      when "Saturday"
        day_week = "土"
      when "Sunday"
        day_week = "日"
      end
    else
    end
    return day_week
  end

  # get the detail date(2011/04/11(月)17:00)
  def get_detail_date(date)
    unless date.blank?
      "#{date_time_format_i(date)}" + "(#{day_week(date)})" + "#{date.strftime('%H:%M')}" rescue '--'
    end
  end

  # calculate from the current_time in 60 days
  def time_allow(get_time, min_period_time, max_period_time)
    to_time = Time.parse(get_time)
    now_time = Time.now
    return  to_time - now_time <  max_period_time - min_period_time &&  to_time - now_time >  min_period_time
  end

  def time_allow_before_over(end_time, max_period_time)
    to_time = Time.parse(end_time)
    now_time = Time.now
    return to_time - now_time > 0 && to_time - now_time < max_period_time
  end
  # end by dxy 20110714

  def show_date_format(time)
    unless time.blank?
      time.strftime("%Y年%m月%d日") rescue '--'
    end
  end
  
  #【引数】value to boolean
  #【返値】
  #【注意】
  #【著作】by mrq 20110119
  def to_boolean(value)
    return if value.blank?
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
  end


  # 根据不同的条件合并成一个新的条件
  #【引数】
  #【返值】
  #【注意】
  #【著作】 by dxy 20110624
  def get_new_conn(role_conn, conns)
    conns << role_conn[1]
    conns[0] = conns[0] +  " and " + role_conn[0]
    return conns.flatten
  end

  def get_new_or_conn(role_conn, conns)
    role_conn << conns[1..conns.length - 1]
    role_conn[0] = role_conn[0] + " and " + "(" + conns[0] + ")"
    role_conn.flatten!
  end

  # 如果字符大于10，那么取字符串的前三个字符，后面字符用"..."代替显示
  #【引数】
  #【返值】
  #【注意】
  #【著作】 by dxy 20110705
  def sub_str(string)
    if string.to_s.size > 12*8
      return "#{string.slice(0...12*8)}..."
    else
      return string
    end
  end



  #根据邮政编码转换地址
  #【引数】
  #【返值】
  #【注意】
  #【著作】 by hx 20100528
  def jp_zip2pref(zip)

    pref = nil

    case zip
    when /^01/
      pref = "秋田県"
    when /^02/
      pref = "岩手県"
    when /^03/
      pref = "青森県"
    when /^0[4-9]/
      pref = "北海道"
    when /^1/
      pref = "東京都"
    when /^2[1-5]/
      pref = "神奈川県"
    when /^2[6-9]/
      pref = "千葉県"
    when /^3[0-1]/
      pref = "茨城県"
    when /^32/
      pref = "栃木県"
    when /^3[3-6]/
      pref = "埼玉県"
    when /^37/
      pref = "群馬県"
    when /^3[8-9]/
      pref = "長野県"
    when /^40/
      pref = "山梨県"
    when /^4[1-3]/
      pref = "静岡県"
    when /^4[4-9]/
      pref = "愛知県"
    when /^50/
      pref = "岐阜県"
    when /^51/
      pref = "三重県"
    when /^52/
      pref = "滋賀県"
    when /^5[3-9]/
      pref = "大阪府"
    when /^6[0-2]/
      pref = "京都府"
    when /^63/
      pref = "奈良県"
    when /^64/
      pref = "和歌山県"
    when /^6[5-7]/
      pref = "兵庫県"
    when /^68/
      pref = "鳥取県"
    when /^69/
      pref = "島根県"
    when /^7[0-1]/
      pref = "岡山県"
    when /^7[2-3]/
      pref = "広島県"
    when /^7[4-5]/
      pref = "山口県"
    when /^76/
      pref = "香川県"
    when /^77/
      pref = "徳島県"
    when /^78/
      pref = "高知県"
    when /^79/
      pref = "愛媛県"
    when /^8[03]/
      pref = "福岡県"
    when /^84/
      pref = "佐賀県"
    when /^8[15]/
      pref = "長崎県"
    when /^86/
      pref = "熊本県"
    when /^87/
      pref = "大分県"
    when /^88/
      pref = "宮崎県"
    when /^89/
      pref = "鹿児島県"
    when /^90/
      pref = "沖縄県"
    when /^91/
      pref = "福井県"
    when /^92/
      pref = "石川県"
    when /^93/
      pref = "富山県"
    when /^9[4-5]/
      pref = "新潟県"
    when /^96/
      pref = "福島県"
    when /^98/
      pref = "宮城県"
    when /^99/
      pref = "山形県"
    end
    pref
  end
  
  private 
  # 上記メソッドのオプションに与えられた文字列が正しいかチェック
  # 間違っている場合は、例外を返す
  def validate_from_code_opt(str)
    unless %w(E S J W).include?(str)
      raise 'OptionIsInvalid'
    end
  end
  
end

class Time
  def beginning_of_hour
    "#{self.strftime("%Y-%m-%d %H")}:00:00".to_time(:local)
  end
  
  def end_of_hour
    "#{self.strftime("%Y-%m-%d %H")}:59:59".to_time(:local)
  end
end

class DateTime
  def beginning_of_hour
    "#{self.strftime("%Y-%m-%d %H")}:00:00".to_time(:local)
  end
  
  def end_of_hour
    "#{self.strftime("%Y-%m-%d %H")}:59:59".to_time(:local)
  end
  
end