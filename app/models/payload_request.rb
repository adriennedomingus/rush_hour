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

  def self.average_response_time
    average(:responded_in)
  end

  def self.maximum_response_time
    maximum(:responded_in)
  end

  def self.minimum_response_time
    minimum(:responded_in)
  end

  def self.most_frequent_request_type
    #WHAT IF THERE IS A TIE?
    all_verbs = []
    all.each do |payload_request|
      all_verbs << payload_request.request_type.verb
    end
    highest = all_verbs.group_by { |verb| verb}.map do |key, value|
      [key, value.count]
    end.max_by { |total| total[1] }
    highest[0]
  end

  def self.all_http_verbs
    all_verbs = []
    all.each do |payload_request|
      all_verbs << payload_request.request_type.verb
    end
    all_verbs
  end

end
