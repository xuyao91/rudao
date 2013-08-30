class Auth < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  belongs_to :user, :conditions => ["users.deleted_at is null"]
  
  #默认生成邀请码的数据100条
  def self.generate_auth_code
    count = 1
    sum = 100
    while count <=sum do
      code = UUIDTools::UUID.random_create.to_s[0,21].gsub('-','')
      @auth = Auth.find_by_code(code)
      if @auth.present?
        next
      else
        @auth = Auth.create(:code => code, :usable=> 1)
        pp "auth code generate successful with #{count}/#{sum}"
        logger.info "auth code generate successful with #{count}/#{sum}"
        count += 1
      end
    end
  end
  
end
