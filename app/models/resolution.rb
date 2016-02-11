class Resolution < ActiveRecord::Base
  validates :width, :height,  presence: true
  has_many :payload_requests

  def self.all_resolutions
    all = joins(:payload_requests).group("resolutions.id", :width, :height).order(count: :desc, width: :asc, height: :asc).count
    all.keys.map do |resolution|
      "#{resolution[1]} x #{resolution[2]}"
    end
  end
end
