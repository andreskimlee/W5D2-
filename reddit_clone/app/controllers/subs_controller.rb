class SubsController < ApplicationController
  before_action :ensure_logged_in
  before_action :is_moderator?, only: [:edit, :update]

  # GET /subs
  # GET /subs.json
  def index
    @subs = Sub.all
  end

  # GET /subs/1
  # GET /subs/1.json
  def show
    @sub = Sub.find(params[:id])
  end

  # GET /subs/new
  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  # POST /subs
  # POST /subs.json
  def create
    @sub = Sub.new(sub_params)  
    @sub.moderator_id = current_user.id 
      if @sub.save
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages 
        render :new 
      end    
  end

  # PATCH/PUT /subs/1
  # PATCH/PUT /subs/1.json
  def update
    @sub = Sub.find(params[:id]) ## 
      if @sub.update(sub_params)
        redirect_to sub_url(@sub)
      else
         flash.now[:errors] = @sub.errors.full_messages 
        render :edit 
      end
    
  end

  # DELETE /subs/1
  # DELETE /subs/1.json
  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url 
  end

  private
    def sub_params
      params.require(:sub).permit(:title, :description)
    end
end
