require File.expand_path('../../test_helper',  __FILE__)
require 'shoulda'

class SignatureTest < ActiveSupport::TestCase


  context "Signature" do

    setup do
      @version_list = [['paperclip', '1.1', 'gem']]
      @sig_orig = Signature.create_from_array(@version_list)
      @sig_db = Signature.last
    end

    should "there is at least one version in a signature" do
      assert_equal 1, @sig_db.versions.count
    end

    should "creating a version and a component out of json" do
      first = @sig_db.versions.first
      assert_equal "1.1", first.version_num
      assert_equal "paperclip", first.component.name
    end

    should "handle multiple signatues in an array" do
      version_list = [['paperclip', '1.1', 'gem'],['shoulda', '1.4', 'gem'],['authlogic','3.0.0.0.rc', 'gem']]
      sig = Signature.create_from_array(version_list)
      assert_equal 3, sig.versions.count
    end

    should "allow us to alter component type" do
      version_list = [['rails', '2.3.5', 'framework'], ['jon', '2.3.0.0.9', 'gem']]
      sig = Signature.create_from_array(version_list)
      first = Signature.last.versions.first
      last = Signature.last.versions.last
      assert_not_equal first.component.name, last.component.name
      assert_equal 'rails', first.component.name
      assert_equal '2.3.5', first.version_num
      assert_equal 'framework', first.component.c_type
      assert_equal 'jon', last.component.name
      assert_equal '2.3.0.0.9', last.version_num
      assert_equal 'gem', last.component.c_type
    end

  end

  

  


end
