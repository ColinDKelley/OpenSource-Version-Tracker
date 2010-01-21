class Version < ActiveRecord::Base
validates_presence_of :version_num
has_many  :signatures
belongs_to :component
end
