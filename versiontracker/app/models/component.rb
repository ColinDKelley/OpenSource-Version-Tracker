class Component < ActiveRecord::Base
validates_presence_of :name,:type
has_many  :versions
end
