class OferteController < ApplicationController
  def index
    @programs = OfferProgram.active.order(:position)

    @double_program_pairs = @programs.to_h { |p| [p, build_pairs_for(p, people_count: 2)] }
    @single_program_pairs = @programs.to_h { |p| [p, build_pairs_for(p, people_count: 1)] }

    # drop programs with no pairs
    @double_program_pairs.select! { |_program, pairs| pairs.any? }
    @single_program_pairs.select! { |_program, pairs| pairs.any? }
  end

  private

  def build_pairs_for(program, people_count:)
    variants = OfferVariant.active
      .where(offer_program: program, people_count: people_count)

    grouped = variants.group_by { |v| [v.duration_kind, v.nights, v.room_type] }

    pairs = grouped.map do |key, vars|
      {
        key: key,
        demi: vars.find { |v| v.meal_plan == "demi" },
        completa: vars.find { |v| v.meal_plan == "completa" }
      }
    end

    room_order = { "standard" => 1 }
    duration_order = { "intensa" => 1, "prelungita" => 2 }

    pairs.sort_by do |h|
      duration_kind, nights, room_type = h[:key]
      [duration_order[duration_kind] || 9, nights, room_order[room_type] || 9]
    end
  end
end
