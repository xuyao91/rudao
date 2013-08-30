#coding: utf-8
class User < ActiveRecord::Base
  # attr_accessible :title, :body
  acts_as_paranoid
  acts_as_authentic 
end
