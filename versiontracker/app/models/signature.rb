class Signature < ActiveRecord::Base
validates_presence_of :date,:score
has_many :versions
end
