class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status, null: false, default: 0
      t.references :doctor, foreign_key: { to_table: :users }
      t.references :patient, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
