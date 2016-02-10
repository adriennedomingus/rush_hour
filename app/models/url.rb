class Url < ActiveRecord::Base
  validates :path,
  presence: true

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
    self.payload_requests.all_http_verbs
  end

  def top_referrers
    ref_ids = self.payload_requests.pluck(:referral_id)
    id_count = ref_ids.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
    id_count_desc = id_count.sort_by {|k, v| v}.reverse.to_h
    top_ids = id_count_desc.keys[0,3]
    refs = Referral.find(top_ids)
    refs.map {|ref| ref[:path]}
  end

  def top_user_agents
    env_ids = self.payload_requests.pluck(:environment_id)
    id_count = env_ids.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
    id_count_desc = id_count.sort_by {|k, v| v}.reverse.to_h
    top_ids = id_count_desc.keys[0,3]
    envs = Environment.find(top_ids)
    # envs.map {|env| env[:browser]} env[:os] ??
  end
end
