module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do
      # client = Client.find_by(:identifier => :identifier)
      # payload = Payload.create(PayloadParser(params))
      #payload.client_id = client
    end

    post '/sources' do
      the_status, the_body = ClientParser.new(params).parse_paths
      status the_status
      body the_body
    end
  end
end
