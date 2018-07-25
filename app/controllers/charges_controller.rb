class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = charge_params[:amount]
    @user = User.find_by_id(charge_params[:user_id])

    @customer_id = @user.find_or_create_stripe_customer(charge_params[:stripeToken])

    @user.reload
    charge = Stripe::Charge.create(
        :customer    => @customer_id,
        :amount      => @amount,
        :currency    => charge_params[:currency],
        :description => charge_params[:description]
    )

    render json: { message: 'Successful charge!' }

    rescue Stripe::CardError => e
      render json: { message: 'ERROR' }, status: 422
  end

  def subscribe
    @user = User.find_by_id(subscribe_params[:user_id])

    @customer_id = @user.find_or_create_stripe_customer(subscribe_params[:stripeToken])

    subscription = Stripe::Subscription.create(
                                          customer: @customer_id,
                                          items: [
                                              {
                                                  plan: subscribe_params[:plan_id],
                                              },
                                          ],
                                          trial_period_days: subscribe_params[:trial_period_days]
    )

    @user.add_subscription(subscription.id)
    #TODO: add the stripe subscription id to user
    render json: {stripe: subscription }

  end
  #TODO: should we specify which plan
  def cancel_subscription
    @user = User.find_by_id(cancel_params[:user_id])
    #subscription = Stripe::Subscription.retrieve()

    subscription = @user.cancel_subscription

    render json: { stripe: subscription }
  end


  protected

  def charge_params
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
      :stripeToken,
      :trial_period_days
    )
  end

  def cancel_params
    params
    .require(:subscription)
    .permit(
      :user_id
    )
  end

end
