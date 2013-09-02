class Admin < ActiveRecord::Base
  # attr_accessible :title, :body
   acts_as_paranoid
   acts_as_authentic
  #attr_accessible :login, :email, :password, :password_confirmation
end
