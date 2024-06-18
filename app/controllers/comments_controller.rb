class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		post = Post.find(params[:post_id])
	  comment = post.comments.build(comment_params)
	  comment.user_id=current_user.id

	  respond_to do |format|
	    if comment.save
	      format.html { redirect_to comment.post, notice: "Comment was successfully created." }
	    else
	      format.html { render :new, status: :unprocessable_entity }
	    end
	  end
	end

	private

	def comment_params
	 params.require(:comment).permit(:post_id, :content)
	end

end
