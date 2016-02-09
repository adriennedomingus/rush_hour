class EventName < ActiveRecord::Base
  validates :event,
  presence: true

  has_many :payload_requests
end
