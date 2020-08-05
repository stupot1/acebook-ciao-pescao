class PostsController < ApplicationController
  def new
    p "in posts#new session wall_id = " + session[:wall_id].to_s
    @post = Post.new
  end

  def create
    p "in posts#create session wall_id = " + session[:wall_id].to_s
    @post = Post.create(post_params)
    redirect_to posts_url
  end

  def index
    session[:wall_id] = params[:user_id]
    @time = Time.new
    @posts = Post.all.reverse
  end
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.message == post_params[:message]
      flash.now[:messages] = "Not possible. Message has not been changed"
      render :edit
    elsif Time.now - 10.minutes > @post.created_at
      redirect_to posts_url
    else
      @post.update_attributes(post_params)
      redirect_to posts_url
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:message).merge(user_id: current_user.id).merge(wall_id: session[:wall_id])
  end

end
