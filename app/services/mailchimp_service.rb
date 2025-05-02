# app/services/mailchimp_service.rb
require 'faraday'
require 'ostruct'


class MailchimpService
  def initialize
    @api_key = ENV['MAILCHIMP_API_KEY']
    @list_id = ENV['MAILCHIMP_LIST_ID']
    @dc = @api_key.split('-').last # e.g., "us8"
    @url = "https://#{@dc}.api.mailchimp.com/3.0/lists/#{@list_id}/members"
  end
require 'digest/md5'
  def subscribe(email)
    subscriber_hash = Digest::MD5.hexdigest(email.downcase)
    url = "#{@url}/#{subscriber_hash}"

    response = Faraday.put(url) do |req|

      req.headers['Authorization'] = "apikey #{@api_key}"
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        email_address: email,
        status: 'subscribed',
        merge_fields: {
          FNAME: 'Emilia' # Default or fixed value, required by your list
        }
      }.to_json
    end

    puts "Response Status: #{response.status}"
    puts "Response Body: #{response.body}"
    puts "Email being sent: #{email}"

    OpenStruct.new(success?: response.status == 200, response: response)
  end
end
