class Url < ActiveRecord::Base
  validates :path,  presence: true

  has_many :payload_requests
  has_many :referrals, through: :payload_requests

  def max_response_time
    payload_requests.maximum_response_time
  end

  def min_response_time
    payload_requests.minimum_response_time
  end

  def response_times
    payload_requests.pluck(:responded_in)
  end

  def avg_response_time
    payload_requests.average_response_time
  end

  def verbs
    # joins(:request_types).group("request_types.verb").order(count: :desc).count.keys
    verb_ids = payload_requests.pluck(:request_type_id)
    RequestType.find(verb_ids).map {|req| req[:verb]}
  end

  def top_referrers

    # all = payload_requests.joins(:referrals).group("referrals.path")

    all_referrers = payload_requests.map do |payload_request|
      payload_request.referral.path
    end.group_by { |url| url }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
    all_referrers[0,3]
  end

  def self.in_order
    joins(:payload_requests).group("urls.path").order(count: :desc).count.keys
  end

  def top_user_agents
    all_envs = self.payload_requests.map do |payload_request|
      payload_request.environment
    end
    all_envs.group_by { |url| url }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
    all_envs.map {|env| "#{env.browser}, #{env.os}"}[0,3]
    # group().count
    # order()
    # limit()
  end
end
