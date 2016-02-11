module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      payload = PayloadRequest.create(PayloadParser(params[:payload]).payload_hash)

      unique_key = Digest::SHA1.hexdigest(params[:payload])
      #add in hexdigest validation to payload parser

      if payload.save
        status 200
        "Thanks for the payload #{identifier}!"
      end
    end

    post '/sources' do
      the_status, the_body = ClientParser.new(params).parse_paths
      status the_status
      body the_body
    end
  end
end
