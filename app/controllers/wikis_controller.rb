class WikisController < ApplicationController
  def index
    if current_user.standard?
      @wikis = Wiki.where(private: false)
    elsif current_user.premium?
      @wikis = Wiki.where(private: false) 
      @wikis += Wiki.where(user_id: current_user.id)
      @wikis = @wikis.uniq
    else
      @wikis = Wiki.all
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
    @wiki = current_user.wikis.new(wiki_params) 
    
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    authorize @wiki 
    
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private 

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private) 
  end
end