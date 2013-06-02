require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "should not save without fullname, email and github account" do
    member = Member.new
    assert !member.save
  end
end
