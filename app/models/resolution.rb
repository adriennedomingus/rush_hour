class Resolution < ActiveRecord::Base
  validates :width, :height,  presence: true
  has_many :payload_requests

  def self.all_resolutions
    all = joins(:payload_requests).group("resolutions.width", "resolutions.height").count.keys
    all.map do |width, height|
      "#{width} x #{height}"
    end
  end
end
