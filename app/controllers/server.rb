module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources/:identifier/data' do

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
