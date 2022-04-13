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

  it 'returns 404 if invalid data is provided' do
    customer = Customer.create!(first_name: "Seth", last_name: "Perna", email: "gseth26@gmail.com", address: "123 Sesame St")
    tea = Tea.create!(title: "Chamomile", description: "Sleepy Time", temp: 175, brewtime: "00:10:00")
    data = { email: customer.email,
             tea_title: tea.title
     }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    post '/api/v1/subscriptions', headers: headers, params: JSON.generate(data)
    expect(response.status).to eq(404)
  end

  it "cancels a sunscription(patch)" do
    customer = Customer.create!(first_name: "Seth", last_name: "Perna", email: "gseth26@gmail.com", address: "123 Sesame St")
    tea = Tea.create!(title: "Chamomile", description: "Sleepy Time", temp: 175, brewtime: "00:10:00")
    subscription = customer.subscriptions.create!(title: "#{customer.first_name}'s #{tea.title} subscription", price: 10.0, status: 0, frequency: 0)
    tea_sub = TeaSub.create!(tea_id: tea.id, subscription_id: subscription.id)
    data = { email: customer.email,
             tea_id: tea.id,
             subscription_id: subscription.id
     }
    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    patch '/api/v1/subscriptions', headers: headers, params: JSON.generate(data)
    subscription = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
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
    expect(subscription[:data][:attributes][:status]).to eq("inactive")
    expect(subscription[:data][:attributes][:frequency]).to eq("weekly")
  end
end
