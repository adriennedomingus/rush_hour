class PayloadDataResponseParser
  attr_reader :identifier

  def initialize(identifier)
    @client = Client.find_by(:identifier => identifier)
    @identifier = identifier
  end

  def server_response
    if !Client.exists?(identifier: identifier)
      file = :client_not_found
    elsif Client.find_by(:identifier => identifier).payload_requests.all.empty?
      file = :no_payload_submitted
    else
      file = :payload_data
    end
    [file, @client]
  end
end
