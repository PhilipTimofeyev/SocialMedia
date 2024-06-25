class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
	  @comment = @post.comments.build(comment_params)
	  @comment.user_id=current_user.id

	  # debugger

    if @comment.save
      redirect_to @comment.post.user
      # render :post
    else
      render :new, status: :unprocessable_entity
    end
	end

	def destroy
	  @comment = Comment.find(params[:id])
	  @post = Post.first
	  @comment.destroy

	  redirect_to posts_path, status: :see_other
	end

	private

	def comment_params
	 params.require(:comment).permit(:post_id, :content)
	end

end
