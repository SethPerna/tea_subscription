require 'rails_helper'
RSpec.describe 'subscription request' do
  it 'creates a subscription for a customer' do
    customer = Customer.create!(first_name: "Seth", last_name: "Perna", email: "gseth26@gmail.com", address: "123 Sesame St")
    tea = Tea.create!(title: "Chamomile", description: "Sleepy Time", temp: 175, brewtime: "00:10:00")
    frequency = 2
    data = { email: customer.email,
             tea_title: tea.title,
             frequency: frequency
     }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/subscriptions', headers: headers, params: JSON.generate(data)
    subscription = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(subscription).to have_key(:data)
    expect(subscription[:data]).to have_key(:id)
    expect(subscription[:data]).to have_key(:type)
    expect(subscription[:data][:type]).to eq("subscription")
    expect(subscription[:data]).to have_key(:attributes)
    expect(subscription[:data][:attributes]).to have_key(:title)
    expect(subscription[:data][:attributes]).to have_key(:price)
    expect(subscription[:data][:attributes]).to have_key(:status)
    expect(subscription[:data][:attributes]).to have_key(:frequency)
    expect(subscription[:data][:attributes][:title]).to eq("Seth's Chamomile subscription")
    expect(subscription[:data][:attributes][:price]).to eq(10.0)
    expect(subscription[:data][:attributes][:status]).to eq("active")
    expect(subscription[:data][:attributes][:frequency]).to eq("monthly")
  end
end
