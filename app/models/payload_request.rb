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


  def self.all_browsers_in_order
    group(:id).order('environment_id ASC').map do |payload_request|
      payload_request.environment.browser
    end.group_by { |browser| browser }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  end

  def self.all_os_in_order
    group(:id).order('environment_id ASC').map do |payload_request|
      payload_request.environment.os
    end.group_by { |os| os }.map do |key, value|
      [key, value.count]
    end.sort_by { |key, value| value}.reverse.map { |totals| totals[0] }
  end
end
