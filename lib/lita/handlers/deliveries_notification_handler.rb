require 'json'
require 'httparty'

module Lita
  module Handlers
    class DeliveriesNotificationHandler < Handler
      SUBJECT_REGEX = /You have a delivery from/.freeze
      UUID_REGEX = /[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}/.freeze
      PRODUCT_NAME = 'deliveries'.freeze

      # URL to webhook when we see a Deliveries noticiation
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
        )
        response.reply(payload.to_json)
      end
    end

    Lita.register_handler(DeliveriesNotificationHandler)
  end
end
