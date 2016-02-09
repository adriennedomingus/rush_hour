class Environment < ActiveRecord::Base
  validates :os, :browser,
  presence: true

  has_many :payload_requests
end
