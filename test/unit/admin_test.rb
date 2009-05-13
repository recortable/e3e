require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Admin.new.valid?
  end
end
