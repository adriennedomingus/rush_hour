class PayloadRequest < ActiveRecord::Base
  validates :requested_at,
            :responded_in,
            :url_id,
            :ip_id,
            :event_name_id,
            :environment_id,
            :request_type_id,
            :referral_id,
            :resolution_id,
            presence: true

  belongs_to :url
  belongs_to :ip
  belongs_to :referral
  belongs_to :request_type
  belongs_to :resolution
  belongs_to :environment
  belongs_to :event_name
  belongs_to :client

  def self.average_response_time
    average(:responded_in)
  end

  def self.maximum_response_time
    maximum(:responded_in)
  end

  def self.minimum_response_time
    minimum(:responded_in)
  end
end
