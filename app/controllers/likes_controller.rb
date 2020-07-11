class LikesController < ApplicationController
    before_action :find_likeable
    before_action :authenticate_user!
    respond_to :js
  
    def create
      @likeable.liked_by current_user
      #  redirect_to posts_path
    end
  
    def destroy
      @likeable.disliked_by current_user
    end
  
    private
    def find_likeable
      @votable_type = params[:votable_type].classify
      @votable = @votable_type.constantize.find(params[:votable_id])
    end
end
