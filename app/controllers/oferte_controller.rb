class OferteController < ApplicationController
def index
  @programs = OfferProgram.active.order(:position)

  @program_pairs = @programs.index_with do |program|
    build_pairs_for(program)
  end
end

private

def build_pairs_for(program)
  variants = OfferVariant.active
    .where(offer_program: program, people_count: 2)
    .order(:position)

  grouped = variants.group_by { |v| [v.duration_kind, v.nights, v.room_type] }

  pairs = grouped.map do |key, vars|
    {
      key: key,
      demi: vars.find { |v| v.meal_plan == "demi" },
      completa: vars.find { |v| v.meal_plan == "completa" }
    }
  end

  room_order = { "superior" => 1, "standard" => 2, "economy" => 3 }
  duration_order = { "intensa" => 1, "prelungita" => 2 }

  pairs.sort_by do |h|
    duration_kind, nights, room_type = h[:key]
    [duration_order[duration_kind] || 9, nights, room_order[room_type] || 9]
  end
end

end

