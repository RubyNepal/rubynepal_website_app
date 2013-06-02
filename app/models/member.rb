class Member < ActiveRecord::Base
  attr_accessible :email, :employement, :full_name, :github, :linkedin, :short_bio, :twitter
  validates_presence_of :email, :full_name, :github

  default_scope order('created_at DESC')

end
