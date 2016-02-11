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
  end

end
