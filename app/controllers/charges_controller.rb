class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = stripe_params[:amount]

    customer = Stripe::Customer.create(
      :source  => stripe_params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
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
        :stripeToken,
        :amount,
        :description,
        :currency
    )
  end

end
