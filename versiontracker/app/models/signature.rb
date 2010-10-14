# Collection of component versions
class Signature < ActiveRecord::Base
  has_many :signature_versions
  has_many :versions, :through => :signature_versions
  belongs_to :user
  
  validates_presence_of :date, :score

  def self.create_from_array(array)
    s = Signature.create!(:date => Time.now, :score => 1000)
    array.each do |couple|
      component = couple[0]
      version   = couple[1]
      c_type = couple[2]
      version = Version.create_from_hash({"component" => {"name" => component, "c_type" => c_type}, "version_num" => version})
      s.versions << version
    end
    s
  end
end
