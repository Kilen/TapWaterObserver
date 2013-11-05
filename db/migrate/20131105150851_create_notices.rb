class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :time
      t.string :event

      t.timestamps
    end
  end
end
