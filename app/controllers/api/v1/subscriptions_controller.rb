class Api::V1::SubscriptionsController < ApplicationController
  before_action :set_subscription, except: %i[create]
  rescue_from Exception, :with => :stripe_error_handling
  def show
    render json: @subscription
  end
  
  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      render json: @subscription, status: :created
    else 
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  def update
    if @subscription.update(subscription_params)
      render json: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @subscription.destroy
    render json: "Your subscription has been deleted."
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
  
  def subscription_params
    params.require(:data).permit(:card_number, :exp_month, :exp_year, :cvc, :user_id, :plan_id, :active)
  end

  
end