require 'json'
require 'httparty'

module Lita
  module Handlers
    class DeliveriesNotificationHandler < Handler
      SUBJECT_REGEX = /You have a delivery from/

      route(SUBJECT_REGEX, :notify_delivery)

      def notify_delivery(response)
        response.reply("TEST RESPONSE -> #{response.message} -> #{response.message.body} -> #{response.message.extensions}")
      end
    end
    Lita.register_handler(DeliveriesNotificationHandler)
  end
end
