# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :ensure_canonical_host_and_ssl
  private

  def ensure_canonical_host_and_ssl
    canonical = "hotelvacanta.ro"
    if request.host != canonical || !request.ssl?
      redirect_to(
        "https://#{canonical}#{request.fullpath}",
        status: :moved_permanently,
        allow_other_host: true    # ← this tells Rails it’s OK
      )
    end
  end
end
