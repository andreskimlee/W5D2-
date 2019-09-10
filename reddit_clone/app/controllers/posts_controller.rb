class PostsController < ApplicationController
  before_action :ensure_logged_in 

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id]) 
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
      if @post.save
        # params[:sub_ids].each do |id|
        #   PostSub.create(sub_id: id, post_id: @post.id)
        # end
        redirect_to post_url(@post) 
      else
        flash.now[:errors] = @post.errors.full_messages
        render :new 
      end
    
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to post_url(@post) 
      else
        flash.now[:errors] = @post.errors.full_messages
        render :edit 
      end
    
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids:[]) 
    end
end
