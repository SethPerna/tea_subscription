class Api::V1::SubscriptionsController < ApplicationController
  before_action :find_data
  def index
    if @customer != nil
      render json: CustomerSubscriptionSerializer.new(@customer.subscriptions)
    else
      return invalid_request
    end
  end

  def create
    if params[:email].present?
      subscription = @customer.subscriptions.create(title: "#{@customer.first_name}'s Tea subscription", price: 10.0, frequency: params[:frequency], customer_id: @customer.id)
      tea_sub = TeaSub.create(tea_id: @tea.id, subscription_id: subscription.id)
      if subscription.save
        render json: SubscriptionSerializer.new(subscription), status: 201
      else
        return invalid_request
      end
    end
  end

  def update
    if params[:subscription_id].present?
      subscription = Subscription.find(params[:subscription_id])
      subscription.update(status: 1)
      tea_sub = TeaSub.find_by(tea_id: @tea.id, subscription_id: subscription.id)
      tea_sub.destroy

      if subscription.save
        render json: SubscriptionSerializer.new(subscription)
      end
    else
      return invalid_request
    end
  end

  private

  def find_data
    @customer = Customer.find_by(email: params[:email])
    @tea = Tea.find_by(title: params[:tea_title])
  end

  def invalid_request
    render json: { data: { message: 'Invalid Request' } }, status: 404
  end
end
