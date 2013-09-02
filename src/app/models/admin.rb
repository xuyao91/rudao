class Admin < ActiveRecord::Base
  # attr_accessible :title, :body
   acts_as_paranoid
   acts_as_authentic do |c|
      c.validate_email_field = true
      c.validate_login_field = true
      c.validate_password_field = true
      c.require_password_confirmation=true
   end
   attr_accessor :password_confirmation
   # validates :login,          :uniqueness => true, :if => proc{|t|t.login.present?}
   # validates :login,          :presence => true
   #validates :email,           :presence => true#,:if => proc{|t|t.name.present?}
   #validates :password,       :presence => true#,:if => proc{|t|t.password.present?}
   #validates :password_confirmation, :presence => true#,:if => proc{|t|t.password_confirmation.present?}
   
   def self.get_conditions params
     conn = [[]]
     if params[:login].present?
       conn[0] << "login like ?"
       conn << "%#{params[:login].strip}%"
     end
     if params[:email].present?
       conn[0] << "email like ?"
       conn << "%#{params[:email].strip}%"
     end
     conn[0] = conn[0].join(' and ')
     return conn
   end
   
end
