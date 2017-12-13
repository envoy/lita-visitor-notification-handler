require 'json'
require 'httparty'

module Lita
  module Handlers
    class VisitorNotificationHandler < Handler
      PRODUCT_NAME = 'vr'
      # URL to webhook when we see a visitor noticiation
      config :webhook_url

      route(/^(.+) is here to see you at (.+)\.$/, :notify_visitor)
      route(/^(.+) is here to see no host at (.+)\.$/, :notify_visitor)

      def notify_visitor(response)
        groups = response.matches[0]
        if groups.size == 2
          payload = {
            guest_name: groups[0],
            location_name: groups[1],
            product: PRODUCT_NAME
          }
        else
          payload = {
            host_name: groups[0],
            guest_name: groups[1],
            location_name: groups[2],
            product: PRODUCT_NAME
          }
        end
        
        HTTParty.post(
          config.webhook_url,
          body: payload.to_json
        )
        response.reply(payload)
      end
    end
    Lita.register_handler(VisitorNotificationHandler)
  end
end
