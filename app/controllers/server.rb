module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|



      unique_key = Digest::SHA1.hexdigest(params[:payload])
      #add in hexdigest validation to payload parser
      parsed_payload = PayloadParser.new(params[:payload]).payload_hash
      payload = PayloadRequest.create(parsed_payload)

      if payload.save
        status 200
        "Thanks for the payload #{identifier}!"
      end


    end

    post '/sources' do
      data = {:root_url => params[:rootUrl],
              :identifier => params[:identifier]}
      client = Client.new(data)
      if client.save
        status 200
        body "{\"identifier\":\"#{client.identifier}\"}"
      elsif client.errors.full_messages.include?("Identifier has already been taken")
        status 403
        body client.errors.full_messages.join(", ")
      else
        status 400
        body client.errors.full_messages.join(", ")
      end
    end
  end
end
