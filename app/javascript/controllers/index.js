import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

import CarouselController from "./carousel_controller"
application.register("carousel", CarouselController)

eagerLoadControllersFrom("controllers", application)
