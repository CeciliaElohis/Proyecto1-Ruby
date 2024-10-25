# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :destroy]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id # Asignar el usuario actual al post
    if @post.save
      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.join(", ")
      render :new
    end
  end
  

  # GET /posts/:id
  def show
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "El post fue actualizado exitosamente."
    else
      render :edit
    end
  end

  # DELETE /posts/:id
  def destroy
    if @post.destroy
      flash[:success] = "The post has been successfully deleted!"
      redirect_to posts_path
    else
      flash[:error] = "There was a problem deleting the post."
      redirect_to posts_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    unless @post.user_id == current_user.id
      flash[:alert] = "No tienes permiso para realizar esta acción."
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :description)
  end
end
