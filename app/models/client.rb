class Client < ActiveRecord::Base
  validates :identifier, presence: true, uniqueness: true
  validates :root_url, presence: true

  has_many :payload_requests, :dependent => :destroy
  has_many :urls, through: :payload_requests
  has_many :environments, through: :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :event_names, through: :payload_requests
  has_many :resolutions, through: :payload_requests
end
