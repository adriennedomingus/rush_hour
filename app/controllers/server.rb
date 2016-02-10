module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      "Hi"
      #data will come from parameters
      # client = Client.new(data)
      #
      # if client.save
      #   status 200
      #   body {"identifier":"#{client.identifier}"}
      # elsif #already exists
      #   status 403
      #   body "That identifier already exists"
      # else
      # #if missing parameters
      #   status 400
      #   body client.errors.full_messages.join(", ")
    end
  end
end
