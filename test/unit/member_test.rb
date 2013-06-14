require 'test_helper'
require "mocha/setup"

class MemberTest < ActiveSupport::TestCase

  test "should not save without fullname, email and github account" do
    assert !Member.new.save
  end

  test "should populate score and set avatar url" do
    member = members(:one)
    Github::Event.any_instance.stubs(:get).returns(JSON.parse(File.read("#{Rails.root}/test/fixtures/github_response.txt")))
    member.populate_score_and_avatar
    assert_equal 47, member.score
    assert_equal "http://gravatar.com/avatar/68952cca8d9631003516ac20e2b39f25", member.avatar_url
  end

end
