require 'json'
require 'httparty'

module Lita
  module Handlers
    class DeliveriesNotificationHandler < Handler
      SUBJECT_REGEX = /You have a delivery from/
      UUID_REGEX = /[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}/
      PRODUCT_NAME = 'deliveries'

      # URL to webhook when we see a deliveries noticiation
      config :webhook_url

      route(SUBJECT_REGEX, :notify_delivery)

      def notify_delivery(response)
        delivery_id = response.message.body.match(UUID_REGEX)[0]

        payload = {
          delivery_id: delivery_id,
          product: PRODUCT_NAME
        }

        HTTParty.post(
          config.webhook_url,
          body: payload.to_json,
          headers: config.webhook_headers,
        )
        response.reply(payload)
      end
    end
    Lita.register_handler(DeliveriesNotificationHandler)
  end
end
