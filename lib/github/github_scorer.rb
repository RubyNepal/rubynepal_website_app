class GithubScorer
  attr_reader :events, :total_score, :avatar, :username

  def initialize(data, username)
    @username =  username
    @data = data
    parse
    score
  end

  def score
    @total_score = 0
    @events.each do |event|
      @total_score += case event
        when 'CommitCommentEvent' then 2
        when 'IssueCommentEvent' then 2
        when 'IssuesEvent' then 3
        when 'WatchEvent' then 1
        when 'PullRequestEvent' then 5
        when 'PushEvent' then 7
        when 'FollowEvent' then 1
        when 'CreateEvent' then 3
        else 0
      end
    end
    self
  end

  private

  def parse
    if @data.is_a?(Hash) && @data.has_key?("error")
      @events = []
      @avatar = ""
    else
      @events = @data.collect{|e| e['type']}
      @data.each do |event|
        if event['actor'].downcase == @username.downcase
          @avatar = event['actor_attributes']['gravatar_id']
        end
        break
      end
    end
  end
end
