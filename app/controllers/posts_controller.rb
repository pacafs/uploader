class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    @posts  = Post.all
    @images = @posts.collect{ |p| p.pictures }

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def new
  	@post = Post.new
  end

  def show
    @post   = Post.find(params[:id])
    	
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
		if params[:pictures]
          # The magic is here ;)
          params[:pictures].each { |image|
            @post.pictures.create(image: image)
          }
        end
        format.html { redirect_to post_path(@post), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(post_params)
        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @post.pictures.create(image: image)
          }
        end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :pictures)
  end

end
