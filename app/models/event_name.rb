class EventName < ActiveRecord::Base
  validates :event, presence: true

  has_many :payload_requests

  def self.in_order
    joins(:payload_requests).group("event_names.event").order(count: :desc).count.keys
  end

  def hour_by_hour
    hours = (1..24).to_a
    count = []
    24.times do
      count << 0
    end
    hours.zip(count).to_h
  end

  def by_hour
    all = hour_by_hour
    payload_requests.pluck(:requested_at).map do |time_string|
      Time.parse(time_string).hour
    end.each do |hour|
      all[hour] += 1
    end
    all
  end
end
