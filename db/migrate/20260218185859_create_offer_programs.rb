class CreateOfferPrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_programs do |t|
      t.string :key
      t.string :title
      t.jsonb :includes_bullets
      t.integer :position
      t.boolean :active

      t.timestamps
    end
  end
end
