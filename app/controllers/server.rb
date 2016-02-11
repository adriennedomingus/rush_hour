module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do |identifier|
      the_status, the_body = PayloadRequestParser.new(params[:payload], identifier).server_response
      status the_status
      body the_body
    end

    post '/sources' do
      the_status, the_body = ClientResponseParser.new(params).server_response
      status the_status
      body the_body
    end

    get '/sources/:identifier' do |identifier|
      require "pry"
      binding.pry
      if Client.find_by(identifier: identifier) == nil
        erb :client_not_found
      elsif Client.find_by(:identifier => identifier).payload_requests.all.empty?
        erb :no_payload_submitted
      end
    end
  end
end
