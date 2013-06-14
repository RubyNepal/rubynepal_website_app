require 'test_helper'

class GithubScorerTest < ActiveSupport::TestCase

  test "should calculate scores based on github activity" do
    data = JSON.parse(File.read("#{Rails.root}/test/fixtures/github_response.txt"))
    gh = GithubScorer.new(data, "rohitrox")
    assert_equal 47, gh.total_score
    assert_equal "68952cca8d9631003516ac20e2b39f25", gh.avatar
  end

end