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
            :client_id,
            presence: true

  belongs_to :url, :dependent => :destroy
  belongs_to :ip, :dependent => :destroy
  belongs_to :referral, :dependent => :destroy
  belongs_to :request_type, :dependent => :destroy
  belongs_to :resolution, :dependent => :destroy
  belongs_to :environment, :dependent => :destroy
  belongs_to :event_name, :dependent => :destroy
  belongs_to :client

  def self.average_response_time(client)
    where(:client_id => client.id).average(:responded_in)
  end

  def self.maximum_response_time(client)
    where(:client_id => client.id).maximum(:responded_in)
  end

  def self.minimum_response_time(client)
    where(:client_id => client.id).minimum(:responded_in)
  end

end
