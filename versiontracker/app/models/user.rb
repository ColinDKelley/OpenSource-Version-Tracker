class User < ActiveRecord::Base
validates_presence_of :username,:password,:api_key
has_many :signatures
end
