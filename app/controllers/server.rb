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
      if Client.find_by(identifier: identifier) == nil
        erb :client_not_found
      elsif Client.find_by(:identifier => identifier).payload_requests.all.empty?
        erb :no_payload_submitted
      else
        @client = Client.find_by(:identifier => identifier)
        erb :payload_data
      end
    end

    helpers do

      def link_to_url_statistics(path, url)
        "<a href= '<%= http://localhost:9393/sources/#{@client.identifier}/urls/#{path} %>' >#{url}</a>"
      end
    end
  end
end
