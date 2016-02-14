class Url < ActiveRecord::Base
  validates :path,  presence: true

  has_many :payload_requests, :dependent => :destroy
  has_many :referrals, through: :payload_requests
  has_many :environments, through: :payload_requests
  has_many :request_types, through: :payload_requests

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
    request_types.group(:verb).order(count: :desc).count.keys
  end

  def top_referrers
    referrals.group(:path).order(count: :desc).limit(3).count.keys
  end

  def self.in_order
    joins(:payload_requests).group("urls.path").order(count: :desc).count.keys
  end

  def top_user_agents
    environments.group(:browser, :os).order(count: :desc).limit(3).count.keys.map do |browser, os|
      "#{browser}, #{os}"
    end
  end
end
