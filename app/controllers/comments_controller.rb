class CommentsController < ApplicationController
  before_action :set_listing

  def create
      @comment = @listing.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to @listing
      else
        flash.now[:alert] = "error"
      end
    end
    

    private 

    
    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def comment_params
      params.require(:comment).permit(:body,:user_id,:listing_id)
    end



end
