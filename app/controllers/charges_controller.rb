class ChargesController < ApplicationController
  def new
    #premium membership charge amount in cents
    @amount = 1500
    
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Premium Membership - #{current_user.email}",
     amount: @amount
    }
  end
  
  def create
    #premium membership charge amount in cents
    @amount = 1500
    
    #create Stripe customer object
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )
      
    #create the Stripe charge object
    charge = Stripe::Charge.create(
      customer: customer.id, #note this is different than your app's user.id/user_id
      amount: @amount,
      description: "Premium Membership: #{current_user.email}",
      currency: 'usd'
      )
    
    if flash[:error].present?
      e = Stripe::CardError
      flash[:alert] = e.message
      redirect_to new_charge_path
    else
      current_user.role = 'premium'
      current_user.charge_id = charge.id
      current_user.save!
    
      flash[:notice] = "Thanks for upgrading your account, #{current_user.email}!"
      redirect_to wikis_path
    end
  end
end