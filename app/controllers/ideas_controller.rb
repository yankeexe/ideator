class IdeasController < ApplicationController
    def index
        @idea=Idea.order("created_at DESC")
        @idea=Idea.paginate(:page => params[:page],:per_page => 6)
    end
    
    def create
        @idea= Idea.create(idea_params)
        if @idea.valid?
            flash[:success]= "Your idea has been posted"
        else
            flash[:alert] = "There is an error"
        end
        redirect_to root_path
    end
    
    def edit
        @idea= Idea.find(params[:id])
    end
    
    def update
         @idea = Idea.find(params[:id])
         if @idea.update(idea_params)
            flash[:success] = "Your Idea has been updated."
            redirect_to root_path
         else
            flash[:alert]= "An error occured while updating the Record"
            redirect_to edit_idea_path(params[:id])
         end
    end
    
    def destroy
        @idea =Idea.find(params[:id])
        @idea.destroy
        flash[:success]="The idea has been successfully deleted"
        redirect_to root_path
    end
    
    private
    def idea_params
        params.require(:idea).permit(:description,:author)
    end
end
