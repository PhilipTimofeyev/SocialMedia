class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :update, :destroy, :like, :unlike]


	def index
		@posts = Post.where(user_id: current_user.following).or Post.where(user_id:current_user.id)
	end

	def new
	  @post = Post.new
	end

	def create
	  @post = current_user.posts.build(post_params)

	  if @post.save
	    redirect_to posts_path
	  else
	    render :new, status: :unprocessable_entity
	  end
	end

	def edit
	  @post = Post.find(params[:id])
	end

	def update
	  @post = Post.find(params[:id])

	  if @post.update(post_params)
	    redirect_to posts_path
	  else
	    render :edit, status: :unprocessable_entity
	  end
	end

	def destroy
	  @post = Post.find(params[:id])
	  @post.destroy

	  redirect_to posts_path, status: :see_other
	end

	def like
		current_user.likes.create(likeable: @post)
		render partial: "posts/post", locals: { post: @post}
	end

	def unlike
		current_user.likes.find_by(likeable: @post).destroy
		render partial: "posts/post", locals: { post: @post}
	end

	private

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
