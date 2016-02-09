class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string :userAgent
    end
  end
end
