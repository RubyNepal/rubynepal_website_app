require_relative '../../lib/github'

class Member < ActiveRecord::Base
  attr_accessible :email, :employement, :full_name, :github, :linkedin, :short_bio, :twitter, :score, :avatar_url
  validates_presence_of :email, :full_name, :github

  default_scope order('created_at DESC')

  def populate_score_and_avatar
    gh_hash = GithubScorer.new(Github::Event.new(self.github).get, self.github)
    self.score = gh_hash.total_score
    self.avatar_url = "http://gravatar.com/avatar/#{gh_hash.avatar}"
    self.save!
  end

  def self.refresh_data
    members = Member.where(active: true).all
    members.each do |e|
      gh = GithubScorer.new(Github::Event.new(e.github).get, e.github)
      e.update_attribute(:score, gh.total_score)
    end
  end

end
