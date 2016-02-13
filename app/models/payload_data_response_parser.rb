class PayloadDataResponseParser

  def server_response(identifier)
    if !Client.exists?(identifier: identifier)
      file = :client_not_found
    elsif Client.find_by(:identifier => identifier).payload_requests.all.empty?
      file = :no_payload_submitted
    else
      file = :payload_data
    end
    file
  end
end
