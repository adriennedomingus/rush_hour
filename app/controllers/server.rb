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

    get '/sources/:identifier/urls/:relativepath' do |identifier, relativepath|
      client = Client.find_by(identifier: identifier)
      relative_path = "#{client.root_url}/#{relativepath}"
      url = client.urls.find_by(path: relative_path)
      erb :specific_url, locals: {url: url}
    end
  end
end
