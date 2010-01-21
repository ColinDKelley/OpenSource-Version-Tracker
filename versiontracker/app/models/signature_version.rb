class SignatureVersion < ActiveRecord::Base
has_and_belongs_to_many :signatures
has_and_belongs_to_many :versions
end
