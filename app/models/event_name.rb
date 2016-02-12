class EventName < ActiveRecord::Base
  validates :event, presence: true

  has_many :payload_requests

  def self.in_order
    joins(:payload_requests).group("event_names.event").order(count: :desc).count.keys
  end

  def hour_by_hour
    # hours = (1..24).to_a
    # count = []
    # 24.times do
    #   count << 0
    # end
    # hours.zip(count).to_h
    { 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0,
    11 => 0, 12 => 0, 13 => 0, 14 => 0, 15 => 0, 16 => 0, 17 => 0, 18 => 0, 19 => 0, 20 => 0,
  21 => 0, 22 => 0, 23 => 0, 24 => 0, }
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
