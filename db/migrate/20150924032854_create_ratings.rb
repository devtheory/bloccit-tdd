class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :rate, index: true, foreign_key: true
      t.references :rateable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
