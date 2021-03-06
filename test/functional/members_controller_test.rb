require 'test_helper'
require "mocha/setup"

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { email: @member.email, employement: @member.employement, full_name: @member.full_name, github: @member.github, linkedin: @member.linkedin, short_bio: @member.short_bio, twitter: @member.twitter }
    end

    assert_response :success
  end

  test "should not allow member index edit delete to world" do
    get :index
    assert_response 401
    get :edit, {id: @member}
    assert_response 401
    put :update, {id: @member}
    assert_response 401
    put :toggle_status, {id: @member}
    assert_response 401
    delete :destroy, {id: @member}
    assert_response 401
  end

  test "should toggle the status of member with put toggle_status and calculate score when activated" do
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("admin", "admin")
    Github::Event.any_instance.stubs(:get).returns(JSON.parse(File.read("#{Rails.root}/test/fixtures/github_response.txt")))
    put :toggle_status, {id: @member}
    assert @member.reload.active
    assert_equal 47, @member.reload.score
    put :toggle_status, {id: @member}
    assert !@member.reload.active
  end

end
