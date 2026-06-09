module OferteHelper
  def duration_label(kind)
    kind == "prelungita" ? "prelungită" : "intensă"
  end

  def meal_plan_label(plan)
    plan == "demi" ? "demi-pensiune" : "pensiune completă"
  end

  def room_label(room_type, people_count)
    # keeping your current wording; refine later for 1 person
    case room_type
    when "superior" then "Cameră dublă superioară cu balcon (matrimonială/twin)"
    else room_type
    end
end
def offer_title(v)
  prefix =
    case v.offer_program.key
    when "balneo" then "balneo"
    when "ozon" then "cu Ozon"
    when "balneo_ozon" then "balneo cu Ozon"
    when "relaxare" then "de relaxare"
    else v.offer_program.title
    end

  "Vacanța de sănătate #{prefix} #{duration_label(v.duration_kind)} cu #{meal_plan_label(v.meal_plan)}"
end


  def meal_details_line(plan)
    return "Demi-pensiune (mic dejun și la alegere prânz sau cină)" if plan == "demi"
    "Pensiune completă"
  end
end