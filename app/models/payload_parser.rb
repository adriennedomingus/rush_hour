
class PayloadParser

  def initialize(payload)
    payload_into_hash(payload)
  end

  def payload_into_hash(payload)
    @payload_hash = {
      :url          => payload[:url],
      :requested_at => payload[:requestedAt],
      :responded_in => payload[:respondedIn],
      :referral     => Referral.create(path: payload[:referredBy]),
      :verb         => RequestType.create(verb: payload[:requestType]),
      :event_name   => EventName.create(event: payload[:eventName]),
      :environment  => UserAgent.parse(payload[:userAgent]),
      :resolution   => Resolution.create(width: payload[:resolutionWidth], height: payload[:resolutionHeight]),
      :ip           => payload[:ip]}
  end

end
