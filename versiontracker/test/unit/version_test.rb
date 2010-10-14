require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  test "creating a version and a componenet out of json" do
    hash = {"version_num" => "2.3", "component" => {"name" => "rails", "c_type" => "gem"}}
    v_orig = Version.create_from_hash(hash)
    v_db = Version.last
    assert_equal v_db.id, v_orig.id
    assert_equal "2.3", v_db.version_num
    c = Component.last
    assert_equal "rails", c.name
    assert_equal "gem", c.c_type
  end
  
  test "creating a version and component raises without a component" do
    hash = {"version" => {"version_num" => "2.3"}}
    assert_raises RuntimeError do
      Version.create_from_hash(hash)
    end
  end
end
