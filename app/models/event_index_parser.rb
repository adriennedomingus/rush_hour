class EventIndexParser
  attr_reader :identifier

  def initialize(identifier)
    @identifier = identifier
    @client = Client.find_by(identifier: @identifier)
  end

  def server_response
    if !Client.exists?(identifier: identifier)
      file = :client_not_found
    else
      file = :event_index
    end
    [file, @client]
  end
end
