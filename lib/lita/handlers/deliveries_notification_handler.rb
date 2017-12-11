require 'json'
require 'httparty'

module Lita
  module Handlers
    class DeliveriesNotificationHandler < Handler
      SUBJECT_REGEX = /delivery/
      # URL to webhook when we see a visitor noticiation
      config :webhook_url
      # header for webhook request
      config :webhook_headers

      route(SUBJECT_REGEX, :notify_delivery)

      def notify_delivery(response)
        HTTParty.post(
          "https://requestb.in/1jc4kro1",
          body: response
        )
        response.reply(response)
      end
    end

    Lita.register_handler(DeliveriesNotificationHandler)
  end
end
