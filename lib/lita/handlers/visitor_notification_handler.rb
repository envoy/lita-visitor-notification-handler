require 'json'
require 'httparty'

module Lita
  module Handlers
    class VisitorNotificationHandler < Handler
      # URL to webhook when we see a visitor noticiation
      config :webhook_url
      # header for webhook request
      config :webhook_headers

      route(/^(.+) is here to see you at (.+) - front desk$/, :notify_visitor)
      route(/^(.+) is here at (.+) - front desk$/, :notify_visitor)

      def notify_visitor(response)
        groups = response.matches[0]
        if groups.size == 2
          notification = {
            :guest_name => groups[0],
            :location_name => groups[1],
          }
        else
          notification = {
            :host_name => groups[0],
            :guest_name => groups[1],
            :location_name => groups[2],
          }
        end
        payload = notification.to_json
        if config.webhook_url
          resp = HTTParty.post(
            config.webhook_url,
            body: payload,
            headers: config.webhook_headers,
          )
        end
        response.reply(payload)
      end
    end

    Lita.register_handler(VisitorNotificationHandler)
  end
end
