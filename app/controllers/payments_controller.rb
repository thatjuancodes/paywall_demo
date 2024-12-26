class PaymentsController < ApplicationController
  def new
  end

  def create
    @amount = payment_params[:amount]

    payment_intent = Stripe::PaymentIntent.create(
      amount: @amount,
      currency: 'usd'
    )

    render json: { client_secret: payment_intent.client_secret }
  rescue Stripe::StripeError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def payment_params
    params.require(:payment).permit(:amount)
  end
end