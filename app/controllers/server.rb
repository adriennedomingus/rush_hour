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

    get '/createaccount' do
      erb :create_account
    end

    post '/sources' do
      the_status, the_body = ClientResponseParser.new(params).server_response
      status the_status
      body the_body
    end

    get '/allsources' do
      erb :all_clients
    end

    get '/sources/:identifier' do |identifier|
      file, client = PayloadDataResponseParser.new(identifier).server_response
      erb file, locals: { client: client }
    end

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      file, relative_path, url, client = UrlPathResponseParser.new(identifier, relativepath).server_response
      erb file, locals: { url: url, relative_path: relative_path, client: client}
    end

    get '/:identifier/events' do |identifier|
      file, client = EventIndexParser.new(identifier).server_response
      erb file, locals: {client: client}
    end

    get '/events/:client/:event_name' do |client_name, event_name|
      client = Client.find_by(identifier: client_name)
      if client != nil
        event = client.event_names.find_by(:event => event_name)
      end
      if !Client.exists?(identifier: client_name)
        erb :client_not_found
      elsif !client.event_names.exists?(:event => event_name)
        redirect "/#{client_name}/events"
      else
        erb :hourly_breakdown, locals: { event: event, client: client }
      end
    end

    get '/:identifier/update' do |identifier|
      client = Client.find_by(identifier: identifier)
      erb :update_client, locals: { client: client }
    end

    put '/:identifier/update' do |identifier|
      client = Client.find_by(identifier: identifier)
      client.update(identifier: params[:client][:identifier], root_url: params[:client][:rooturl])
      redirect '/allsources'
    end

    get '/:identifier/delete' do |identifier|
      if !Client.exists?(identifier: identifier)
        redirect "/sources/#{identifier}"
      else
        client = Client.find_by(identifier: identifier)
        erb :delete_client, locals: {client: client }
      end
    end

    delete '/:identifier/delete' do |identifier|
      client = Client.find_by(identifier: identifier)
      Client.destroy(client.id)
      erb :account_deleted
    end

    helpers do
      def link_to_url_statistics(client, path, url)
        "<a href= 'http://localhost:9393/sources/#{client.identifier}/urls/#{path}' >#{url}</a>"
      end

      def singluar_or_plural_hits(hits)
        hits == 1 ? "hit" : "hits"
      end

      def link_to_main_statistics(client)
        "<a href='/sources/#{client.identifier}'>RETURN TO ALL #{client.identifier.upcase} STATS</a>"
      end
    end
  end
end
