class CreatePayloadRequests < ActiveRecord::Migration
  def change
    create_table :payload_requests do |t|
      t.string :requested_at
      t.integer :responded_in
      t.integer :url_id
      t.integer :ip_id
      t.integer :event_name_id
      t.integer :user_agent_id
      t.integer :request_type_id
      t.integer :referral_id
      t.integer :resolution_id
    end
  end
end
