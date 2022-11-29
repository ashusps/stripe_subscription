class Api::V1::PlansController < ApplicationController
  before_action :set_plan, except: %i[create index]
  rescue_from Exception, :with => :stripe_error_handling
  def index
    @plans = Plan.all
    render json: @plans.order("created_at ASC")
  end

  def show
    render json: @plan
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      render json: @plan, status: :created
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  def update
    if @plan.update(plan_params)
      render json: @plan
    else
      render json: @plan.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @plan.destroy
    render json: "Your plan has been deleted."
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :description, :interval, :price_cents)
  end

end