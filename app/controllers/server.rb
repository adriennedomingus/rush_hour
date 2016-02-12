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

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      client = Client.find_by(identifier: identifier)
      relative_path = "#{client.root_url}/#{relativepath}"
      if client.urls.find_by(path: relative_path) == nil
        "Url (#{relative_path}) has not been requested."
      else
        url = client.urls.find_by(path: relative_path)
        erb :specific_url, locals: {url: url}
      end
    end

    get '/:identifier/events' do |identifier|
      @client = Client.find_by(identifier: identifier)
      erb :event_index
    end

    get '/events/:client/:event_name' do |client_name, event_name|
      client = Client.find_by(identifier: client_name)
      #Do we need another sad path for if the client can't be found?
      if client.event_names.find_by(:event => event_name) == nil
        redirect "/#{client_name}/events"
      else
        @event = client.event_names.find_by(:event => event_name)
        erb :hourly_breakdown
      end
    end

    helpers do
      def link_to_url_statistics(path, url)
        "<a href= '<%= http://localhost:9393/sources/#{@client.identifier}/urls/#{path} %>' >#{url}</a>"
      end
    end

  end
end
