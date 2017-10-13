class CollaboratorsController < ApplicationController
    before_action :set_wiki
    
    def new
       @collaborator = Collaborator.new 
    end
    
    def create
        @user = User.find_by_email(params[:email])
    
        if @wiki.collaborators.exists?(user_id: @user.id)
            flash[:alert] = "That user is already a collaborator for this wiki."
            redirect_to edit_wiki_path(@wiki)
        else
            @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: @user.id)
        
            if @collaborator.save
                flash[:notice] = "#{@user.email} has been added as a collaborator."
                redirect_to edit_wiki_path(@wiki)
            else
                flash[:alert] = "There was an error adding this collaborator. Please try again."
                redirect_to edit_wiki_path(@wiki)
            end
        end
    end
    
    def destroy
        @user = User.find_by_email(params[:email])
        @collaborator = Collaborator.find(params[:id])
        
        if @collaborator.destroy
            flash[:notice] = "#{@collaborator.user.email} has been removed as a collaborator."
            redirect_to edit_wiki_path(@wiki)
        else
            flash[:alert] = "There was an error removing this collaborator. Please try again."
            redirect_to edit_wiki_path(@wiki)
        end
    end
    
    private
    
    def set_wiki
       @wiki = Wiki.find(params[:wiki_id]) 
    end
end
