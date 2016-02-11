class EventName < ActiveRecord::Base
  validates :event, presence: true

  has_many :payload_requests

  def self.in_order
    joins(:payload_requests).group("event_names.event").order(count: :desc).count.keys
  end
end
