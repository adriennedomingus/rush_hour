class CreateReferredBy < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :referredBy
    end
  end
end
