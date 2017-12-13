require 'json'
require 'spec_helper'

describe Lita::Handlers::DeliveriesNotificationHandler, lita_handler: true do

  before { allow(HTTParty).to receive(:post) }

  it { is_expected.not_to route('How are you doing') }
  it { is_expected.not_to route('To code or not to code, that is a question') }
  it { is_expected.not_to route('How do you turn this one?') }
  it { is_expected.not_to route('YOLO') }
  it { is_expected.not_to route('lol') }
  it { is_expected.to route('You have a delivery from US Postal Service!') }
  it { is_expected.to route('You have a delivery from  Other!.') }

  it 'consumes and replies message' do
    send_message('You have a delivery from US Postal Service!<http://localhost:3001/a/deliveries/user_actions/acknowledge?id=0939f462-2b2a-4e1e-aba0-bb7aafbff7d4&token=eyJhb....')
    expect(JSON.parse(replies.last)).to eq({
        'delivery_id' => '0939f462-2b2a-4e1e-aba0-bb7aafbff7d4',
        'product' => 'deliveries'
    })
  end

  it 'makes a request to the webhook' do
    send_message('You have a delivery from US Postal Service!<http://localhost:3001/a/deliveries/user_actions/acknowledge?id=0939f462-2b2a-4e1e-aba0-bb7aafbff7d4&token=eyJhb....')
    expect(HTTParty).to have_received(:post)
  end
end
