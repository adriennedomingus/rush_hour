class RenameIpAddress < ActiveRecord::Migration
  def change
    rename_column :ips, :ip_address, :address
  end
end
