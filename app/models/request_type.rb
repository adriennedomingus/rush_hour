class RequestType < ActiveRecord::Base
  validates :verb, presence: true

  has_many :payload_requests

  def self.in_order
    joins(:payload_requests).group("request_types.verb").order(count: :desc).count.keys
  end

  def self.most_frequent
    in_order[0]
  end
end
