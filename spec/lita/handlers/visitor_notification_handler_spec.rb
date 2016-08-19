require 'json'
require 'spec_helper'

describe Lita::Handlers::VisitorNotificationHandler, lita_handler: true do
  it { is_expected.not_to route('How are you doing') }
  it { is_expected.not_to route('To code or not to code, that is a question') }
  it { is_expected.not_to route('How do you turn this one?') }
  it { is_expected.not_to route('YOLO') }
  it { is_expected.not_to route('lol') }
  it { is_expected.to route('foo bar is here to see you at Envoy.') }
  it { is_expected.to route('af1c3a41-b65d-4ee5-8f07-4a76ffcd1528 is here to see you at Envoy.') }
  it { is_expected.to route('0c984ee5-1e07-4344-b726-2a3e10284c32 is here to see no host at Envoy.') }
  it { is_expected.to route('Foo bar is here to see no host at Envoy.') }

  it 'consumes and replies message' do
    send_message('foo bar is here to see you at Envoy.')
    expect(JSON.parse(replies.last)).to eq({
        'guest_name' => 'foo bar',
        'location_name' => 'Envoy',
    })
  end
  it 'consumes UUID guest name and replies message' do
    send_message('af1c3a41-b65d-4ee5-8f07-4a76ffcd1528 is here to see you at Big Brother.')
    expect(JSON.parse(replies.last)).to eq({
        'guest_name' => 'af1c3a41-b65d-4ee5-8f07-4a76ffcd1528',
        'location_name' => 'Big Brother',
    })
  end
end
