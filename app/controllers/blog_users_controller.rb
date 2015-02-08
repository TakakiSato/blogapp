class BlogUsersController < ApplicationController
  before_action :set_blog_user, only: [:show, :edit, :update, :destroy]

  # GET /blog_users
  # GET /blog_users.json
  def index
    @blog_users = BlogUser.all
  end

  # GET /blog_users/1
  # GET /blog_users/1.json
  def show
  end

  # GET /blog_users/new
  def new
    @blog_user = BlogUser.new
  end

  # GET /blog_users/1/edit
  def edit
  end

  # POST /blog_users
  # POST /blog_users.json
  def create
    @blog_user = BlogUser.new(blog_user_params)

    respond_to do |format|
      if @blog_user.save
        format.html { redirect_to @blog_user, notice: 'Blog user was successfully created.' }
        format.json { render :show, status: :created, location: @blog_user }
      else
        format.html { render :new }
        format.json { render json: @blog_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_users/1
  # PATCH/PUT /blog_users/1.json
  def update
    respond_to do |format|
      if @blog_user.update(blog_user_params)
        format.html { redirect_to @blog_user, notice: 'Blog user was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_user }
      else
        format.html { render :edit }
        format.json { render json: @blog_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_users/1
  # DELETE /blog_users/1.json
  def destroy
    @blog_user.destroy
    respond_to do |format|
      format.html { redirect_to blog_users_url, notice: 'Blog user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_user
      @blog_user = BlogUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_user_params
      params[:blog_user]
    end
end
