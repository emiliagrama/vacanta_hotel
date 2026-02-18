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
    when "standard" then "Cameră dublă standard cu balcon (matrimonială/twin)"
    when "economy"  then "Cameră dublă economy fără balcon (matrimonială/twin)"
    else room_type
    end
end
 def offer_title(v)
    "Vacanța de sănătate balneo #{duration_label(v.duration_kind)} cu #{meal_plan_label(v.meal_plan)}, în cameră #{v.room_type}"
  end

  def meal_details_line(plan)
    return "Demi-pensiune (mic dejun și la alegere prânz sau cină)" if plan == "demi"
    "Pensiune completă"
  end
end