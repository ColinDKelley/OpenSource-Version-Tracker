# Like a Gem
class Component < ActiveRecord::Base

  validates_presence_of :name, :c_type
  has_many  :versions

  def self.create_from_hash(hash)
    name = hash['name'] or raise "No name!"
    c_type = hash['c_type'] or raise "No component type!"
    c = self.find_or_initialize_by_name_and_c_type(name, c_type)
    c.save!
    c
  end
end
