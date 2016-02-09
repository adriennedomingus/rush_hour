class PayloadRequestsForeignIds < ActiveRecord::Migration
  def change
    add_column :payload_requests, :referralId, :integer
    remove_column :payload_requests, :referred_by
    add_column :payload_requests, :requestTypeId, :integer
    remove_column :payload_requests, :request_type
    add_column :payload_requests, :userAgentId, :integer
    remove_column :payload_requests, :user_agent
    add_column :payload_requests, :resolutionId, :integer
    remove_column :payload_requests, :resolution_height
    remove_column :payload_requests, :resolution_width
    add_column :payload_requests, :ipID, :integer
    remove_column :payload_requests, :ip
  end
end
