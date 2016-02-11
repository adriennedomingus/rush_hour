class ClientResponseParser

  def initialize(params)
    data = {:root_url => params[:rootUrl],
            :identifier => params[:identifier]}
    @client = Client.new(data)
  end

  def server_response
    if @client.save
      status = 200
      body = "{\"identifier\":\"#{@client.identifier}\"}"
    elsif @client.errors.full_messages.include?("Identifier has already been taken")
      status = 403
      body = all_error_messages
    else
      status = 400
      body = all_error_messages
    end
    [status, body]
  end

  def all_error_messages
    @client.errors.full_messages.join(", ")
  end

end
