class Environment < ActiveRecord::Base
  validates :os, :browser, presence: true

  has_many :payload_requests


  #THESE ARE DEPENDENT ON EACH OTHER - THE SAME BROWSER OR OS CAN APPEAR MULTIPLE TIMES IF IT'S COMBINED DIFFERENTLY
  def self.browsers_in_order
    joins(:payload_requests).group("environments.id", :browser).order(count: :desc, browser: :asc).count.keys.map do |browser|
      browser[1]
    end
  end

  def self.os_in_order
    all = joins(:payload_requests).group("environments.id", :os).order(count: :desc, os: :asc).count
    all.keys.map do |os|
      os[1]
    end
  end
end
