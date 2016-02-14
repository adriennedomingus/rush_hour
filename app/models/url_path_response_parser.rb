class UrlPathResponseParser

  def initialize(identifier, relativepath)
    @client = Client.find_by(identifier: identifier)
    if @client != nil
      @relative_path = "#{@client.root_url}/#{relativepath}"
      @url = @client.urls.find_by(path: @relative_path)
    end
  end

  def server_response
    if @client == nil
      file = :client_not_found
    elsif !@client.urls.exists?(path: @relative_path)
      file = :unrequested_path
    else
      file = :specific_url
    end
    [file, @relative_path, @url, @client]
  end
end
