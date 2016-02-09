class Url < ActiveRecord::Base
  validates :path,
  presence: true

  has_many :payload_requests
end
