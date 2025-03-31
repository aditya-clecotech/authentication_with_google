class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path, notice: "Post was successfully created!"
    else 
      flash[:alert] =  "Something went wrong , while creating post..."
      render :new 
    end
  end

  def destroy  #post delete functionality
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post was successfully deleted.'
      redirect_to posts_url
    else
      flash[:alert] = 'Something went wrong'
      redirect_to posts_url
    end
  end
  
  def destroy_image #post's image delete functionality
    @post = Post.find(params[:id])
    image = @post.images.find(params[:image_id])
    image.purge 
    redirect_to @post, notice: "Image has successfully removed!"
  end
  
  def post_params
    params.require(:post).permit(:title, images: [])
  end 

end
