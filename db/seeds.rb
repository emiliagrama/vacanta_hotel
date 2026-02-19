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
  title: "Vacanța de sănătate balneo",
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
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "demi",    room_type: "superior", price_ron: 2600, position: 1 },
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "demi",    room_type: "standard",  price_ron: 2380, position: 2 },
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "demi",    room_type: "economy",  price_ron: 1980, position: 3 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "completa", room_type: "superior", price_ron: 3100, position: 4 },
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "completa", room_type: "standard",  price_ron: 2880, position: 5 },
  { people_count: 2, duration_kind: "intensa",   nights: 5, meal_plan: "completa", room_type: "economy",  price_ron: 2480, position: 6 },

  # 10 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",  room_type: "superior", price_ron: 4960, position: 7 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",  room_type: "standard",  price_ron: 4520, position: 8 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",  room_type: "economy",  price_ron: 4120, position: 9 },

  # 10 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 5960, position: 10 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard",  price_ron: 5520, position: 11 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 5120, position: 12 }
]

balneo_rows.each { |attrs| balneo.offer_variants.create!(attrs.merge(active: true)) }

balneo_single_rows = [
  # =========================
  # BALNEO - SINGLE (1 pers)
  # =========================

  # 5 nopti - demi - 1 pers
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",    room_type: "superior", price_ron: 1925, position: 101 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",    room_type: "standard", price_ron: 1815, position: 102 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",    room_type: "economy",  price_ron: 1615, position: 103 },

  # 5 nopti - completa - 1 pers
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "superior", price_ron: 2125, position: 104 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "standard", price_ron: 2015, position: 105 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "economy",  price_ron: 1815, position: 106 },

  # 10 nopti - demi - 1 pers
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",    room_type: "superior", price_ron: 3630, position: 107 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",    room_type: "standard", price_ron: 3520, position: 108 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",    room_type: "economy",  price_ron: 3320, position: 109 },

  # 10 nopti - completa - 1 pers
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 4130, position: 110 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard", price_ron: 4020, position: 111 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 3820, position: 112 }
]

balneo_single_rows.each { |attrs| balneo.offer_variants.create!(attrs.merge(active: true)) }


ozon = OfferProgram.create!(
  key: "ozon",
  title: "Vacanța de sănătate cu Ozon",
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
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "superior", price_ron: 2600, position: 201 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "standard", price_ron: 2380, position: 202 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "economy",  price_ron: 1980, position: 203 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "superior", price_ron: 3100, position: 204 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "standard", price_ron: 2880, position: 205 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "economy",  price_ron: 2480, position: 206 },

  # 10 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "superior", price_ron: 4960, position: 207 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "standard", price_ron: 4520, position: 208 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "economy",  price_ron: 4120, position: 209 },

  # 10 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 5960, position: 210 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard", price_ron: 5520, position: 211 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 5120, position: 212 }
]

ozon_rows.each { |attrs| ozon.offer_variants.create!(attrs.merge(active: true)) }

ozon_single_rows = [

  # =========================
  # OZON - SINGLE (1 pers)
  # =========================

  # 5 nopti - intensa - demi
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",     room_type: "superior", price_ron: 1925, position:301 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",     room_type: "standard", price_ron: 1815, position: 302 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "demi",     room_type: "economy",  price_ron: 1615, position: 303 },

  # 5 nopti - intensa - completa
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "superior", price_ron: 2125, position: 304 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "standard", price_ron: 2015, position: 305 },
  { people_count: 1, duration_kind: "intensa",    nights: 5, meal_plan: "completa", room_type: "economy",  price_ron: 1815, position: 306 },

  # 10 nopti - prelungita - demi
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "superior", price_ron: 3630, position: 307 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "standard", price_ron: 3520, position: 308 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "economy",  price_ron: 3320, position: 309 },

  # 10 nopti - prelungita - completa
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 4130, position: 310 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard", price_ron: 4020, position: 311 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 3820, position: 312 }
]

ozon_single_rows.each { |attrs| ozon.offer_variants.create!(attrs.merge(active: true)) }


balneo_ozon = OfferProgram.create!(
  key: "balneo_ozon",
  title: "Vacanță de sănătate balneo cu Ozon",
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
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "superior", price_ron: 3600, position: 401 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "standard", price_ron: 3380, position: 402 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "demi",     room_type: "economy",  price_ron: 2980, position: 403 },

  # 5 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "superior", price_ron: 4100, position: 405 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "standard", price_ron: 3880, position: 406 },
  { people_count: 2, duration_kind: "intensa",    nights: 5,  meal_plan: "completa", room_type: "economy",  price_ron: 3480, position: 407 },

  # 10 nopti - demi - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "superior", price_ron: 6280, position: 408 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "standard", price_ron: 5840, position: 409 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "economy",  price_ron: 5440, position: 410 },

  # 10 nopti - completa - 2 pers
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 7280, position: 411 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard", price_ron: 6840, position: 412 },
  { people_count: 2, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 6440, position: 413 }
]

balneo_ozon_rows.each { |attrs| balneo_ozon.offer_variants.create!(attrs.merge(active: true)) }

# =========================
# BALNEO + OZON - SINGLE (1 pers)
# =========================

balneo_ozon_single_rows = [
  # 5 nopti - intensă - demi
  { people_count: 1, duration_kind: "intensa", nights: 5,  meal_plan: "demi",     room_type: "superior", price_ron: 2425, position: 401 },
  { people_count: 1, duration_kind: "intensa", nights: 5,  meal_plan: "demi",     room_type: "standard", price_ron: 2315, position: 402 },
  { people_count: 1, duration_kind: "intensa", nights: 5,  meal_plan: "demi",     room_type: "economy",  price_ron: 2115, position: 403 },

  # 5 nopti - intensă - completă
  { people_count: 1, duration_kind: "intensa", nights: 5,  meal_plan: "completa", room_type: "superior", price_ron: 2625, position: 404 },
  { people_count: 1, duration_kind: "intensa", nights: 5,  meal_plan: "completa", room_type: "standard", price_ron: 2515, position: 405 },
  { people_count: 1, duration_kind: "intensa", nights: 5,  meal_plan: "completa", room_type: "economy",  price_ron: 2315, position: 406 },

  # 10 nopti - prelungită - demi
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "superior", price_ron: 4290, position: 407 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "standard", price_ron: 4180, position: 408 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "demi",     room_type: "economy",  price_ron: 3980, position: 409 },

  # 10 nopti - prelungită - completă
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "superior", price_ron: 4790, position: 410 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "standard", price_ron: 4680, position: 411 },
  { people_count: 1, duration_kind: "prelungita", nights: 10, meal_plan: "completa", room_type: "economy",  price_ron: 4480, position: 412 },
]

balneo_ozon_single_rows.each { |attrs| balneo_ozon.offer_variants.create!(attrs.merge(active: true))
}   