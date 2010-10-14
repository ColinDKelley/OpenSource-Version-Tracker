require File.expand_path('../../test_helper',  __FILE__)

class ComponentTest < ActiveSupport::TestCase
  test "component gets created with a hash" do
    hash = {"name" => "rails", "c_type" => "gem"}
    c_orig = Component.create_from_hash(hash)
    c_db = Component.last
    assert_equal c_db, c_orig
    assert_equal "rails", c_db.name
    assert_equal "gem", c_db.c_type
  end
end
