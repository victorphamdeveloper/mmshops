class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    if @user.role == 1
      @user = @user.becomes(Admin)
    elsif @user.role == 2
      @user = @user.becomes(Seller)
    elsif @user.role == 3
      @user = @user.becomes(Buyer)
    end
      
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    #respond_to do |format|
     # format.html # new.html.erb
      #format.json { render json: @user }
    #end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create(params[:user]) 
    if @user.role == 2
      @user.seller_level = 'normal'
    end
    if @user.save
      sign_in @user
      flash[:succeess] = "Sign up successfully"      
      redirect_to @user
    else
      render 'new'
    end
    
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy

    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
    def admin_user
      redirect_to root_path, notice: "You must be admin to do this." unless is_admin(current_user)
    end

    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
