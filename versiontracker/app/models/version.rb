class Version < ActiveRecord::Base
  has_many :signature_versions
  has_many :signatures, :through => :signature_versions
  belongs_to :component

  validates_presence_of :version_num
  
  def self.create_from_hash(hash)
    c_hash = hash['component'] or raise "No component in the crazy hash."
    component = Component.create_from_hash(c_hash)
    version_num = hash['version_num'] or raise "No version number!"
    v = Version.find_or_initialize_by_version_num_and_component_id(version_num, component.id)
    v.save!
    v
  end
end
