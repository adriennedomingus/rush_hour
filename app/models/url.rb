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
    #WE DON'T WANT TO USE THIS METHOD ANYMORE...??
    self.payload_requests.all_http_verbs
  end

  def top_referrers
    all_referrers = self.payload_requests.group(:id).order('referral_id ASC').map do |payload_request|
      payload_request.referral.path
    end.group_by { |url| url }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
    all_referrers[0,3]
  end

  # def top_user_agents
  #   env_ids = self.payload_requests.pluck(:environment_id)
  #   id_count = env_ids.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
  #   id_count_desc = id_count.sort_by {|k, v| v}.reverse.to_h
  #   top_ids = id_count_desc.keys[0,3]
  #   envs = Environment.find(top_ids)
  #   # envs.map {|env| env[:browser]} env[:os] ??
  # end

  def self.in_order
    joins(:payload_requests).group("urls.id", :path).order(count: :desc, path: :asc).count.keys.map do |path|
      path[1]
    end
  end
end
