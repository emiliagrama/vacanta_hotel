class AddConstraintsToOffers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :offer_programs, :key, false
    add_index :offer_programs, :key, unique: true
    change_column_default :offer_programs, :active, from: nil, to: true
    change_column_null :offer_programs, :active, false, true

    change_column_null :offer_variants, :people_count, false
    change_column_null :offer_variants, :meal_plan, false
    change_column_null :offer_variants, :duration_kind, false
    change_column_null :offer_variants, :nights, false
    change_column_null :offer_variants, :room_type, false
    change_column_null :offer_variants, :price_ron, false
    change_column_default :offer_variants, :active, from: nil, to: true
    change_column_null :offer_variants, :active, false, true

    add_index :offer_variants, [:offer_program_id, :people_count]
    add_index :offer_variants, [:meal_plan, :duration_kind, :nights, :room_type]
  end
end
