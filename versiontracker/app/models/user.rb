class User < ActiveRecord::Base
validates_presence_of :username,:password,:api_key
has_and_belongs_to_many :signatures
end
