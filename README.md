# lita-visitor-notification-handler

[![Build Status](https://travis-ci.org/envoy/lita-visitor-notification-handler.svg?branch=master)](https://travis-ci.org/envoy/lita-visitor-notification-handler)

Lita handler for parsing Envoy visitor notification message and Envoy Deliveries messages

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


## Usage

This handler monitors private messages to it, when it sees Envoy visitor or Envoy Deliveries notification message, it parses it and reply the extracted data


For VR:

```
Envoy ッ:
Hello! John Doe is here without a specified host at the Envoy front desk.

Lita bot:
{"guest_name":"John Doe","location_name":"Envoy", "product": "vr"}
```

For Deliveries:

```
Envoy ッ:
You have a delivery from US Postal Service!

Lita bot:
{"delivery_id":"0939f462-2b2a-4e1e-aba0-bb7aafbff7d4","product": "deliveries"}
```

It also makes a post request callback to the webhook you provided, the body will be JSON in these formats

For VR:

```JSON
{
    "host_name": "Host name",
    "guest_name": "Visitor name",
    "location_name": "Location name",
    "product": "vr"
}
```

For Deliveries:

```JSON
{
    "delivery_id": "0939f462-2b2a-4e1e-aba0-bb7aafbff7d4",
    "product": "Visitor deliveries"
}
```
