class Contact < ApplicationRecord
  # Required fields
  validates :name, :phone, :number_of_adults, :number_of_kids,
            :check_in_date, :check_out_date, :package,
            :preference_for_confirmation,
            presence: true

  # Optional fields
  # email and message are automatically optional if we don't validate presence

  # Example: if you want phone or email mandatory only if user chooses "phone" or "email" for confirmation,
  # you could add a custom validation. For now, we keep phone required, email optional.
end
