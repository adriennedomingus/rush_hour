class PayloadRequestParser
  attr_reader :payload, :identifier

  def initialize(params, identifier)
    @identifier = identifier
    parsed_payload = PayloadParser.new(params, identifier).payload_hash
    @payload = PayloadRequest.new(parsed_payload)
  end

  def server_response
    if PayloadRequest.find_by(sha: payload.sha)
      status = 403
      body = "Sorry #{identifier}, you already submitted this payload"
    elsif Client.find_by(identifier: identifier) == nil
      status = 403
      body = "Sorry, it looks like you haven't registered your app #{identifier}"
    elsif payload.save
      status = 200
      body = "Thanks for the payload #{identifier}!"
    else
      status = 400
      body = payload.errors.full_messages.join(", ")
    end
    [status, body]
  end
end
