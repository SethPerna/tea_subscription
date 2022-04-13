class Api::V1::SubscriptionsController < ApplicationController
  def create
    if params[:email].present?
      customer = Customer.find_by(email: params[:email])
      tea = Tea.find_by(title: params[:tea_title])
      subscription = Subscription.create(title: "#{customer.first_name}'s #{tea.title} subscription", price: 10.0, frequency: params[:frequency], customer_id: customer.id)
      tea_sub = TeaSub.create(tea_id: tea.id, subscription_id: subscription.id)
      if subscription.save
        render json: SubscriptionSerializer.new(subscription), status: 201
      else
        render status: 404
      end
    end
  end
end
