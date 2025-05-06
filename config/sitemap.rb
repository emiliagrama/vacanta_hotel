# config/sitemap.rb

require 'sitemap_generator'

# Where your sitemap will be hosted
SitemapGenerator::Sitemap.default_host = "https://www.hotelvacanta.ro"

# Where to write the files locally (so they get deployed to public/)
SitemapGenerator::Sitemap.public_path = 'public/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemap/'

SitemapGenerator::Sitemap.create do
  # Root
  add '/',                                   priority: 1.0,  changefreq: 'daily'

  # Top‐level pages
  add '/despre',                             priority: 0.8,  changefreq: 'monthly'
  add '/pachete_si_oferte',                  priority: 0.8,  changefreq: 'weekly'
  add '/tratamente_si_facilitati',           priority: 0.8,  changefreq: 'weekly'
  add '/restaurant_conferinte_si_terasa',    priority: 0.8,  changefreq: 'weekly'
  add '/timp_liber',                         priority: 0.8,  changefreq: 'weekly'

  # Contact form
  add '/contact',                            priority: 0.6,  changefreq: 'monthly'
  add '/contact/thank_you',                  priority: 0.5,  changefreq: 'never'

  # Newsletter create endpoint (if you want it indexed)
  add '/newsletters/create',                 priority: 0.4,  changefreq: 'never'

  # Hidden/legal pages
  add '/termeni_si_conditii',                priority: 0.3,  changefreq: 'yearly'
  add '/politica_confidentialitate',         priority: 0.3,  changefreq: 'yearly'
  add '/politica_cookies',                   priority: 0.3,  changefreq: 'yearly'
end
