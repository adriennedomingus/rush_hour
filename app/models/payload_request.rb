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

end
