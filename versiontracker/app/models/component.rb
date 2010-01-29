class Component < ActiveRecord::Base
  has_many  :versions
  validates_presence_of :name,:type
end
