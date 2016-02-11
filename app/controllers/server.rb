module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      payload_parser = PayloadParser.new(params[:payload], identifier).payload_hash
      payload = PayloadRequest.new(payload_parser)

      if PayloadRequest.find_by(sha: payload.sha)
        status 403
        body "Sorry #{identifier}, you already submitted this payload"
      elsif Client.find_by(identifier: identifier) == nil
        status 403
        body "Sorry, it looks like you haven't registered your app #{identifier}"
      elsif payload.save
        status 200
        body "Thanks for the payload #{identifier}!"
      else
        status 400
        body payload.errors.full_messages.join(", ")
      end
    end

    post '/sources' do
      the_status, the_body = ClientParser.new(params).parse_paths
      status the_status
      body the_body
    end
  end
end
