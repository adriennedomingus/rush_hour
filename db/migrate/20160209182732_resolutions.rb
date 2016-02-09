class Resolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :resolutionHeight
      t.string :resolutionWidth
    end
  end
end
