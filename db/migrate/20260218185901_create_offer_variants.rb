class CreateOfferVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_variants do |t|
      t.references :offer_program, null: false, foreign_key: true
      t.integer :people_count
      t.string :meal_plan
      t.string :duration_kind
      t.integer :nights
      t.string :room_type
      t.integer :price_ron
      t.boolean :active
      t.integer :position

      t.timestamps
    end
  end
end
