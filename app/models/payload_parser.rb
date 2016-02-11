
class PayloadParser
  attr_reader :payload_hash

  def initialize(payload, identifier)
    parsed_payload = JSON.parse(payload)
    payload_into_hash(parsed_payload, identifier)
    @identifier = identifier
  end

  def parse_user_agent(user_agent)
    UserAgent.parse(user_agent)
  end

  def payload_into_hash(parsed_payload, identifier)
    @payload_hash = {
      :url          => Url.find_or_create_by(path: parsed_payload["url"]),
      :requested_at => parsed_payload["requestedAt"],
      :responded_in => parsed_payload["respondedIn"],
      :referral     => Referral.find_or_create_by(path: parsed_payload["referredBy"]),
      :request_type => RequestType.find_or_create_by(verb: parsed_payload["requestType"]),
      :event_name   => EventName.find_or_create_by(event: parsed_payload["eventName"]),
      :environment  => Environment.find_or_create_by(os: parse_user_agent(parsed_payload["userAgent"]).os, browser: parse_user_agent(parsed_payload["userAgent"]).browser),
      :resolution   => Resolution.find_or_create_by(width: parsed_payload["resolutionWidth"], height: parsed_payload["resolutionHeight"]),
      :ip           => Ip.find_or_create_by(address: parsed_payload["ip"]),
      :client     => Client.find_by(identifier: identifier)}
  end
end
