class RequestType < ActiveRecord::Base
  validates :verb, presence: true

  has_many :payload_requests

  def self.in_order
    joins(:payload_requests).group("request_types.id", :verb).order(count: :desc, verb: :asc).count.keys.map do |verb|
      verb[1]
    end
  end

  def self.most_frequent
    in_order[0]
  end
end
