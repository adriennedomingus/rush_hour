class AddingShaColumnToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :sha, :string
  end
end
