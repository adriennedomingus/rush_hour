class EventName < ActiveRecord::Base
  validates :event, presence: true

  has_many :payload_requests

  def self.in_order
    joins(:payload_requests).group("event_names.id", :event).order(count: :desc, event: :asc).count.keys.map do |event|
      event[1]
    end
  end
end
