class RenamePayloadsTable < ActiveRecord::Migration
  def change
    rename_table :payloads, :payload_requests
  end
end
