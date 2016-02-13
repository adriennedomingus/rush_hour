class UrlDataResponseParser

  def server_response(identifier, relativepath)
    client = Client.find_by(identifier: identifier)
    relative_path = "#{client.root_url}/#{relativepath}"
    if !client.urls.exists?(path: relative_path)
      file = :unrequested_path
      loclas = { relative_path: relative_path }
    else
      url = client.urls.find_by(path: relative_path)
      file = :specific_url
      locals = { url: url }
    end
    [file, locals]
  end
end
