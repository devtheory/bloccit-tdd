class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.integer :severity
      t.references :rateable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
