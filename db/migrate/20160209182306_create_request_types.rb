class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.string :requestType
    end
  end
end
