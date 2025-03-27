import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)
import NewsletterController from "./newsletter_controller"
application.register("newsletter", NewsletterController)
