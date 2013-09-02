class Admin < ActiveRecord::Base
  # attr_accessible :title, :body
   acts_as_paranoid
   # acts_as_authentic do |c|
     # c.validate_email_field = true
     # c.validate_login_field = true
     # c.validate_password_field = true
     # #c.validate_password_confirmation_field = true
   # end
  #attr_accessible :login, :email, :password, :password_confirmation
  
  private

def map_openid_registration(registration)
  self.email = registration["email"] if email.blank?
  self.login = registration["login"] if login.blank?
end
end
