class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = stripe_params[:amount]
    @user = User.find_by_id(stripe_params[:user_id])

    @customer_id = @user.stripe_customer_id

    #if the customer doesn't already have stripe id, create a new stripe customer
    if @customer_id.nil?
      customer = Stripe::Customer.create(
          :source  => stripe_params[:stripeToken]
      )

      @customer_id = customer.id
      #save the customer id in user table
      # TODO: move this out of controller and into a model method
      @user.update(stripe_customer_id: @customer_id)
    end

    charge = Stripe::Charge.create(
        :customer    => @customer_id,
        :amount      => @amount,
        :currency    => stripe_params[:currency],
        :description => stripe_params[:description]
    )

    render json: { message: 'Successful charge!' }

    rescue Stripe::CardError => e
      render json: { message: 'ERROR' }, status: 422
  end

  def subscribe
    @user = User.find_by_id(subscribe_params[:user_id])
    @customer_id = @user.stripe_customer_id

    #if the customer doesn't already have stripe id, create a new stripe customer
    if @customer_id.nil?
      customer = Stripe::Customer.create(
          :source  => subscribe_params[:stripeToken]
      )

      @customer_id = customer.id
      #save the customer id in user table
      # TODO: move this out of controller and into a model method
      @user.update(stripe_customer_id: @customer_id)
    end

    subscription = Stripe::Subscription.create(
                                          customer: @customer_id,
                                          items: [
                                              {
                                                  plan: subscribe_params[:plan_id],
                                                  trial_period_days: subscribe_params[:trial_period_days]
                                              },
                                          ]
    )

    render json: {stripe: subscription }

  end


  protected

  def stripe_params
    params
    .require(:charge)
    .permit(
        :user_id,
        :stripeToken,
        :amount,
        :description,
        :currency
    )
  end

  def subscribe_params
    params
    .require(:subscription)
    .permit(
        :user_id,
        :plan_id,
        :trial_subscription_days
    )
  end
end
