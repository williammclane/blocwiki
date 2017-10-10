class DowngradeController < ApplicationController
  def new
  end

  def create
    
    refund = Stripe::Refund.create( charge: 'ch_1B4xsfKboi5kvvQ6o9A3B2jr' )
    
    if refund.status == 'succeeded'
        current_user.update(role: 0)
        
        wikis = current_user.wikis
    
        wikis.each do |wiki|
            if wiki.private
                wiki.private = false
                wiki.save!
            end
        end

        flash[:notice] = "Your account has been downgraded to Standard Membership. Your private wikis are now public and you will recieve a $15.00 refund."
        redirect_to new_charge_path
    else
        flash[:alert] = "There was an error downgrading the membership. Please try again."
        redirect_to new_charge_path
    end
  end
end