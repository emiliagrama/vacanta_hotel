class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :number_of_adults
      t.integer :number_of_kids
      t.date :check_in_date
      t.date :check_out_date
      t.string :package
      t.string :preference_for_confirmation
      t.text :message
      t.boolean :newsletter

      t.timestamps
    end
  end
end
