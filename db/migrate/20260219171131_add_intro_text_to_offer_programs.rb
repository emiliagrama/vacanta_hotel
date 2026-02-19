class AddIntroTextToOfferPrograms < ActiveRecord::Migration[7.1]
  def change
    add_column :offer_programs, :intro_text, :text
  end
end
