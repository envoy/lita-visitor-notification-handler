require 'json'
require 'spec_helper'

describe Lita::Handlers::VisitorNotificationHandler, lita_handler: true do
  it { is_expected.not_to route('How are you doing') }
  it { is_expected.not_to route('To code or not to code, that is a question') }
  it { is_expected.not_to route('How do you turn this one?') }
  it { is_expected.not_to route('YOLO') }
  it { is_expected.not_to route('lol') }
  it { is_expected.to route('Hey Victor! foo bar is here for you at the Envoy front desk.') }
  it { is_expected.to route('Hey Awesome! af1c3a41-b65d-4ee5-8f07-4a76ffcd1528 is here for you at the Envoy front desk.') }
  it { is_expected.to route('Hello! 0c984ee5-1e07-4344-b726-2a3e10284c32 is here without a specified host at the Envoy front desk.') }
  it { is_expected.to route('Hello! Foo bar is here without a specified host at the Envoy front desk.') }

  it 'consumes and replies message' do
    send_message('Hey Victor! foo bar is here for you at the Envoy front desk.')
    expect(JSON.parse(replies.last)).to eq({
        'host_name' => 'Victor',
        'guest_name' => 'foo bar',
        'location_name' => 'Envoy',
    })
  end
  it 'consumes UUID guest name and replies message' do
    send_message('Hey John Doe! af1c3a41-b65d-4ee5-8f07-4a76ffcd1528 is here for you at the Big Brother front desk.')
    expect(JSON.parse(replies.last)).to eq({
        'host_name' => 'John Doe',
        'guest_name' => 'af1c3a41-b65d-4ee5-8f07-4a76ffcd1528',
        'location_name' => 'Big Brother',
    })
  end
  it 'consumes no-host UUID guest name and replies message' do
    send_message('Hello! 0c984ee5-1e07-4344-b726-2a3e10284c32 is here without a specified host at the Envoy front desk.')
    expect(JSON.parse(replies.last)).to eq({
        'guest_name' => '0c984ee5-1e07-4344-b726-2a3e10284c32',
        'location_name' => 'Envoy',
    })
  end

end
