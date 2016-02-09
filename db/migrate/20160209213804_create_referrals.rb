class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :path
    end
  end
end
