class CreateEventNames < ActiveRecord::Migration
  def change
    create_table :event_names do |t|
      t.string :event
    end
  end
end
