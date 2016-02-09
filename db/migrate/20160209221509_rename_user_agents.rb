class RenameUserAgents < ActiveRecord::Migration
  def change
    rename_table :user_agents, :environments
  end
end
