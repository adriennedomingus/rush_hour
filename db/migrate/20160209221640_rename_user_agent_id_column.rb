class RenameUserAgentIdColumn < ActiveRecord::Migration
  def change
    rename_column :payload_requests, :user_agent_id, :environment_id
  end
end
