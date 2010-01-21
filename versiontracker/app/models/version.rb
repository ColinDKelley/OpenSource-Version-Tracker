class Version < ActiveRecord::Base
belongs_to: component
has_many: signatures
end
