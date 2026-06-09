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
  title: "Tratament balnear",
  position: 1,
  active: true,
  includes_bullets: [
    "Consultație medicală de specialitate",
    "4 proceduri de tratament balnear/zi",
    "Acces la bazinul cu apă termală"
  ]
)

balneo_rows = [
  # 5 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "demi",      room_type: "superioară", price_ron: 2600, position: 1 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "completa",  room_type: "superioară", price_ron: 3100, position: 4 },

  # 12 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 12, meal_plan: "demi",    room_type: "superioară", price_ron: 4980, position: 7 },

  # 12 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 12, meal_plan: "completa", room_type: "superioară", price_ron: 5980, position: 10 },
]

balneo_rows.each { |attrs| balneo.offer_variants.create!(attrs.merge(active: true)) }

balneo_single_rows = [
  # =========================
  # BALNEO - SINGLE (1 pers)
  # =========================

  # 5 nopti - demi - 1 pers
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",    room_type: "superioară", price_ron: 1550, position: 101 },

  # 5 nopti - completa - 1 pers
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "superioară", price_ron: 1790, position: 104 },

  # 12 nopti - demi - 1 pers
  { people_count: 1, duration_kind: "prelungita", nights: 12, meal_plan: "demi",    room_type: "superioară", price_ron: 2990, position: 107 },

  # 12 nopti - completa - 1 pers
  { people_count: 1, duration_kind: "prelungita", nights: 12, meal_plan: "completa", room_type: "superioară", price_ron: 3490, position: 110 },
]

balneo_single_rows.each { |attrs| balneo.offer_variants.create!(attrs.merge(active: true)) }


ozon = OfferProgram.create!(
  key: "ozon",
  title: "Tratament cu Ozon",
  position: 2,
  active: true,
  intro_text: "Planul de tratament cu ozon se stabilește în urma consultului medical, în fiecare zi de luni a săptămânii!",

  includes_bullets: [
    "Consultatie medicală de specialitate",
    "1 procedură de ozonoterapie/zi",
    "Acces la bazinul cu apă termală"
  ]
)

ozon_rows = [
  # 5 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "superioară", price_ron: 2600, position: 201 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "superioară", price_ron: 3100, position: 204 },

  # 12 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 12, meal_plan: "demi",     room_type: "superioară", price_ron: 4980, position: 207 },

  # 12 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 12, meal_plan: "completa", room_type: "superioară", price_ron: 5980, position: 210 },
]

ozon_rows.each { |attrs| ozon.offer_variants.create!(attrs.merge(active: true)) }

ozon_single_rows = [

  # =========================
  # OZON - SINGLE (1 pers)
  # =========================

  # 5 nopti - intensa - demi
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",      room_type: "superioară", price_ron: 1550, position:301 },

  # 5 nopti - intensa - completa
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa",  room_type: "superioară", price_ron: 1790, position: 304 },

  # 12 nopti - prelungita - demi
  { people_count: 1, duration_kind: "prelungita", nights: 12, meal_plan: "demi",     room_type: "superioară", price_ron: 2990, position: 307 },

  # 12 nopti - prelungita - completa
  { people_count: 1, duration_kind: "prelungita", nights: 12, meal_plan: "completa", room_type: "superioară", price_ron: 3490, position: 310 },
]

ozon_single_rows.each { |attrs| ozon.offer_variants.create!(attrs.merge(active: true)) }


balneo_ozon = OfferProgram.create!(
  key: "balneo_ozon",
  title: "Tratament balnear cu Ozon",
  position: 3,
  active: true,
  intro_text: "Planul de tratament cu ozon se stabilește în urma consultului medical, în fiecare zi.", # adjust if you have exact text
  includes_bullets: [
    "Consultație medicală de specialitate",
    "4 proceduri de tratament balnear/zi",
    "1 procedură de ozonoterapie/zi",
    "Acces la bazinul cu apă termală"
  ]
)

balneo_ozon_rows = [
  # 5 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "superioară", price_ron: 3600, position: 401 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "superioară", price_ron: 4100, position: 405 },

  # 12 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 12, meal_plan: "demi",     room_type: "superioară", price_ron: 6280, position: 408 },

  # 12 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 12, meal_plan: "completa", room_type: "superioară", price_ron: 6960, position: 411 },
]

balneo_ozon_rows.each { |attrs| balneo_ozon.offer_variants.create!(attrs.merge(active: true)) }

# =========================
# BALNEO + OZON - SINGLE (1 pers)
# =========================

balneo_ozon_single_rows = [
  # 5 nopti - intensă - demi
  { people_count: 1, duration_kind: "intensa",   nights: 5,  meal_plan: "demi",     room_type: "superioară", price_ron: 1990, position: 401 },

  # 5 nopti - intensă - completă
  { people_count: 1, duration_kind: "intensa",   nights: 5,  meal_plan: "completa", room_type: "superioară", price_ron: 2240, position: 404 },

  # 12 nopti - prelungită - demi
  { people_count: 1, duration_kind: "prelungita", nights: 12, meal_plan: "demi",     room_type: "superioară", price_ron: 3580, position: 407 },

  # 12 nopti - prelungită - completă
  { people_count: 1, duration_kind: "prelungita", nights: 12, meal_plan: "completa", room_type: "superioară", price_ron: 3950, position: 410 },
]

balneo_ozon_single_rows.each { |attrs| balneo_ozon.offer_variants.create!(attrs.merge(active: true))
}   