class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nick
      t.boolean :logged_in
      t.timestamp :heartbeat

      t.timestamps
    end
  end
end
