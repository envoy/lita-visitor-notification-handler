require 'json'
require 'httparty'

module Lita
  module Handlers
    class DeliveriesNotificationHandler < Handler
      SUBJECT_REGEX = /delivery/

      route(SUBJECT_REGEX, :notify_delivery)

      def notify_delivery(response)
        response.reply("TEST RESPONSE....")
      end
    end
    puts "DeliveriesNotificationHandler registerd...."
    Lita.register_handler(DeliveriesNotificationHandler)
  end
end
