class LikesController < ApplicationController

	def new
		@like = Like.new
	end

	def create
		like = current_user.likes.build
		post = Post.find_by_id(params['format'].to_i)

		like.post=post

		like.save
	end

	def destroy
	end
end
