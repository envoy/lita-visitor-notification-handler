require 'json'
require 'httparty'

module Lita
  module Handlers
    class DeliveriesNotificationHandler < Handler
      SUBJECT_REGEX = /You have a delivery from/
      UUID_REGEX = /[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}/

      route(SUBJECT_REGEX, :notify_delivery)

      def notify_delivery(response)
        delivery_id = response.message.body.match(UUID_REGEX)[0]

        response.reply("bodu --> #{response.message.body} delivery_id --> #{delivery_id}")
      end
    end
    Lita.register_handler(DeliveriesNotificationHandler)
  end
end
