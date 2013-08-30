#coding: utf-8
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  acts_as_authentic
   # acts_as_authentic do |c|
    # c.my_config_option = 1
  # end
  attr_accessible :login,:email, :password, :password_confirmation
end
