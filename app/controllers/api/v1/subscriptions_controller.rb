class Api::V1::SubscriptionsController < ApplicationController

  def index
    customer = Customer.find_by(email: params[:email])
    if customer != nil
      render json: CustomerSubscriptionSerializer.new(customer.subscriptions)
    else
      render status: 404
    end
  end

  def create
    if params[:email].present?
      customer = Customer.find_by(email: params[:email])
      tea = Tea.find_by(title: params[:tea_title])
      subscription = Subscription.create(title: "#{customer.first_name}'s Tea subscription", price: 10.0, frequency: params[:frequency], customer_id: customer.id)
      tea_sub = TeaSub.create(tea_id: tea.id, subscription_id: subscription.id)
      if subscription.save
        render json: SubscriptionSerializer.new(subscription), status: 201
      else
        render status: 404
      end
    end
  end

  def update
    if params[:subscription_id].present?
      customer = Customer.find_by(email: params[:email])
      subscription = Subscription.find(params[:subscription_id])
      tea = Tea.find(params[:tea_id])
      subscription.update(status: 1)
      tea_sub = TeaSub.find_by(tea_id: params[:tea_id], subscription_id: params[:subscription_id])
      tea_sub.destroy

      if subscription.save
        render json: SubscriptionSerializer.new(subscription)
      else
        render status: 404
      end
    end
  end
end
