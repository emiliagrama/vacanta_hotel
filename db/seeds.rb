# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
OfferVariant.delete_all
OfferProgram.delete_all

balneo = OfferProgram.create!(
  key: "balneo",
  title: "Pachete de tratament balnear",
  position: 1,
  active: true,
  includes_bullets: [
    "Consultație medicală de specialitate",
    "4 proceduri de tratament balnear/zi",
    "Acces la bazinul cu apă termală"
  ]
)

rows = [
  # 5 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "intensa", nights: 5, meal_plan: "demi", room_type: "superior", price_ron: 2600, position: 1 },
  { people_count: 2, duration_kind: "intensa", nights: 5, meal_plan: "demi", room_type: "standard",  price_ron: 2380, position: 2 },
  { people_count: 2, duration_kind: "intensa", nights: 5, meal_plan: "demi", room_type: "economy",  price_ron: 1980, position: 3 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa", nights: 5, meal_plan: "completa", room_type: "superior", price_ron: 3100, position: 4 },
  { people_count: 2, duration_kind: "intensa", nights: 5, meal_plan: "completa", room_type: "standard",  price_ron: 2880, position: 5 },
  { people_count: 2, duration_kind: "intensa", nights: 5, meal_plan: "completa", room_type: "economy",  price_ron: 2480, position: 6 },

  # 10 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi", room_type: "superior", price_ron: 4960, position: 7 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi", room_type: "standard",  price_ron: 4520, position: 8 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi", room_type: "economy",  price_ron: 4120, position: 9 },

  # 10 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 5960, position: 10 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard",  price_ron: 5520, position: 11 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 5120, position: 12 }
]

rows.each { |attrs| balneo.offer_variants.create!(attrs.merge(active: true)) }


ozon = OfferProgram.create!(
  key: "ozon",
  title: "Pachete cu Ozonoterapie",
  position: 2,
  active: true,
  intro_text: "Planul de tratament cu ozon se stabilește în urma consultului medical, în fiecare zi de luni a săptămânii!",

  includes_bullets: [
    "Consultatie medicală de specialitate",
    "1 procedură de ozonoterapie/zi",
    "Acces la bazinul cu apă termală"
  ]
)

rows = [
  # 5 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "superior", price_ron: 2600, position: 101 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "standard", price_ron: 2380, position: 102 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "economy",  price_ron: 1980, position: 103 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "superior", price_ron: 3100, position: 104 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "standard", price_ron: 2880, position: 105 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "economy",  price_ron: 2480, position: 106 },

  # 10 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "superior", price_ron: 4960, position: 107 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "standard", price_ron: 4520, position: 108 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "economy",  price_ron: 4120, position: 109 },

  # 10 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 5960, position: 110 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard", price_ron: 5520, position: 111 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 5120, position: 112 }
]

rows.each { |attrs| ozon.offer_variants.create!(attrs.merge(active: true)) }

