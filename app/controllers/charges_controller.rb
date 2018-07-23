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

end
