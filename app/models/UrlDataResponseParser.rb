class UrlDataResponseParser

  def server_response(identifier, relativepath)
    if !Client.exists?(identifier: identifier)
      file = :client_not_found
    else
      client = Client.find_by(identifier: identifier)
      relative_path = "#{client.root_url}/#{relativepath}"
      if !client.urls.exists?(path: relative_path)
        file = :unrequested_path
      else
        @url = client.urls.find_by(path: relative_path)
        file = :specific_url
      end
    end
  end
end
