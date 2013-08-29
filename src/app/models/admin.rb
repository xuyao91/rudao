class Admin < ActiveRecord::Base
  # attr_accessible :title, :body
  
  acts_as_authentic 
end
