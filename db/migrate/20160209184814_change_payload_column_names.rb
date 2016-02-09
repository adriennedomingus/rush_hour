class ChangePayloadColumnNames < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :requested_at, :requestedAt
    rename_column :payload_requests, :responded_in, :respondedIn
    rename_column :payload_requests, :url_id, :urlId
    rename_column :payload_requests, :ipID, :ipId
    rename_column :payload_requests, :event_name, :eventName
  end
end
