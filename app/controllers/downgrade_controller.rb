class DowngradeController < ApplicationController
  def new
  end

  def create
    @user = current_user 
    @user_wikis = @user.wikis.where(private: true)
    
    refund = Stripe::Refund.create( charge: @user.charge_id )
    
    if refund.status == 'succeeded'
        @user.standard!
        
        @user_wikis.each do |wiki|
            wiki.update_attribute(:private, false)
        end

        flash[:notice] = "Your account has been downgraded to Standard Membership. Your private wikis are now public and you will recieve a $15.00 refund."
        redirect_to new_charge_path
    else
        flash[:alert] = "There was an error downgrading the membership. Please try again."
        redirect_to new_charge_path
    end
  end
end