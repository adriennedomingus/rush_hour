class Environment < ActiveRecord::Base
  validates :os, :browser, presence: true

  has_many :payload_requests

  def self.browsers
    joins(:payload_requests).group("environments.browser").count.keys
  end

  def self.os
    joins(:payload_requests).group("environments.os").count.keys
  end
end
