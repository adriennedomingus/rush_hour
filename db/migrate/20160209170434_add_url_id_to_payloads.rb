class AddUrlIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :url_id, :integer
    remove_column :payloads, :url
  end
end
