class OferteController < ApplicationController
  def index
    @balneo_program = OfferProgram.find_by!(key: "balneo")

    @balneo_variants = OfferVariant
      .active
      .where(offer_program: @balneo_program, people_count: 2)
      .order(:position)

    pairs = @balneo_variants.group_by { |v| [v.duration_kind, v.nights, v.room_type] }

    @balneo_pairs = pairs.map do |key, variants|
      demi = variants.find { |v| v.meal_plan == "demi" }
      completa = variants.find { |v| v.meal_plan == "completa" }
      { key: key, demi: demi, completa: completa }
    end

    # order rows: intensă 5 first, then prelungită 10, and within that superior/standard/economy
    room_order = { "superior" => 1, "standard" => 2, "economy" => 3 }
    duration_order = { "intensa" => 1, "prelungita" => 2 }

    @balneo_pairs = @balneo_pairs.sort_by do |h|
      duration_kind, nights, room_type = h[:key]
      [duration_order[duration_kind] || 9, nights, room_order[room_type] || 9]
    end

  end
end

