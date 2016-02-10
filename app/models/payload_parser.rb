
class PayloadParser
  def initialize(payload)
    payload_into_hash(payload)
  end

  def payload_into_hash(payload)
    @payload_hash = {
      :url          => payload[:url],
      :requested_at => payload[:requestedAt],
      :responded_in => payload[:respondedIn],
      :referral     => Referral.find_or_create_by(path: payload[:referredBy]),
      :verb         => RequestType.find_or_create_by(verb: payload[:requestType]),
      :event_name   => EventName.find_or_create_by(event: payload[:eventName]),
      :environment  => UserAgent.parse(payload[:userAgent]),
      :resolution   => Resolution.find_or_create_by(width: payload[:resolutionWidth], height: payload[:resolutionHeight]),
      :ip           => payload[:ip]}
  end
end
