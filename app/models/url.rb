class Url < ActiveRecord::Base
  validates :path,  presence: true

  has_many :payload_requests

  def max_response_time
    self.payload_requests.maximum_response_time
  end

  def min_response_time
    self.payload_requests.minimum_response_time
  end

  def response_times
    self.payload_requests.pluck(:responded_in)
  end

  def avg_response_time
    self.payload_requests.average_response_time
  end

  def verbs
    verb_ids = self.payload_requests.pluck(:request_type_id)
    reqs = RequestType.find(verb_ids)
    reqs.map {|req| req[:verb]}
  end

  def top_referrers
    all_referrers = self.payload_requests.group(:id).order('referral_id ASC').map do |payload_request|
      payload_request.referral.path
    end.group_by { |url| url }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
    all_referrers[0,3]
  end

  def self.in_order
    joins(:payload_requests).group("urls.id", :path).order(count: :desc, path: :asc).count.keys.map do |path|
      path[1]
    end
  end

  def top_user_agents
    #KEEP PLAYING WITH THIS
    all_envs = self.payload_requests.group(:id).order('environment_id ASC').map do |payload_request|
      payload_request.environment
    end.group_by { |url| url }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
    all_envs.map {|env| "#{env.browser}, #{env.os}"}[0,3]
  end
end
