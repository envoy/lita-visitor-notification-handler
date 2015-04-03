# lita-visitor-notification-handler

Lita handler for parsing Envoy visitor notification message

## Installation

Add lita-visitor-notification-handler to your Lita instance's Gemfile:

``` ruby
gem "lita-visitor-notification-handler"
```

## Configuration

To make this handler send a post request to your webhook, you can specify `webhook_url`

```ruby
Lita.configure do |config|
  config.handlers.visitor_notification_handler.webhook_url = 'http://my-webhook.com'
end
```

If you need extra headers for the post request, you can also use `webhook_headers` to specify it.


## Usage

This handler monitors private messages to it, when it sees Envoy visitor notification message, it parses it and reply the extracted data

```
Envoy ッ:
Hello! John Doe is here without a specified host at the Envoy front desk.

Lita bot:
{"guest_name":"John Doe","location_name":"Envoy"}
```

It also makes a post request callback to the webhook you provided, the body will be JSON in this format

```JSON
{
    "host_name": "Host name",
    "guest_name": "Visitor name",
    "location_name": "Location name"
}
```
