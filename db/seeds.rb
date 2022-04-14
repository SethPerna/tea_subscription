# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all
Subscription.destroy_all
Tea.destroy_all
TeaSub.destroy_all
customer = Customer.create!(first_name: "Seth", last_name: "Perna", email: "gseth26@gmail.com", address: "123 Sesame St")
tea = Tea.create!(title: "Chamomile", description: "Sleepy Time", temp: 175, brewtime: "00:10:00")
subscription = customer.subscriptions.create!(title: "#{customer.first_name}'s #{tea.title} subscription", price: 10.0, status: 0, frequency: 0)
tea_sub = TeaSub.create!(tea_id: tea.id, subscription_id: subscription.id)
customer_1 = Customer.create!(first_name: "Jerry", last_name: "Garcia", email: "direwolf@gmail.com", address: "710 Ashbury St")
tea_1 = Tea.create!(title: "Chamomile", description: "Sleepy Time", temp: 175, brewtime: "00:10:00")
tea_2 = Tea.create!(title: "English Breakfast", description: "Wakey wakey", temp: 175, brewtime: "00:10:00")
tea_3 = Tea.create!(title: "Lemon Honey", description: "ZESTY!!!!", temp: 175, brewtime: "00:10:00")
tea_4 = Tea.create!(title: "Chai", description: "LFG", temp: 175, brewtime: "00:10:00")
subscription_1 = customer_1.subscriptions.create!(title: "#{customer_1.first_name}'s Tea subscription", price: 10.0, status: 0, frequency: 0)
subscription_2 = customer_1.subscriptions.create!(title: "#{customer_1.first_name}'s Tea subscription", price: 20.0, status: 1, frequency: 0)
tea_sub_1 = TeaSub.create!(tea_id: tea_1.id, subscription_id: subscription_1.id)
tea_sub_2 = TeaSub.create!(tea_id: tea_2.id, subscription_id: subscription_1.id)
tea_sub_3 = TeaSub.create!(tea_id: tea_3.id, subscription_id: subscription_2.id)
