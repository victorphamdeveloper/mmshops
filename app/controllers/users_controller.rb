class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy, :ban, :manage_seller]

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

  def manage_seller
    @users = User.where("role = 2")
    if params[:sort_by] == "score_high_low"
      @users = @users.sort!{|a,b| total_likes(a) <=> total_likes(b) }
    elsif params[:sort_by] == "score_low_high"
      @users = @users.sort!{|a,b| total_likes(b) <=> total_likes(a) }
    elsif params[:sort_by] == "created_at_desc"
      @users = @users.order("created_at DESC")
    elsif params[:sort_by] == "created_at_asc"
      @users = @users.order("created_at ASC")
    end

    @users = @users.paginate(page: params[:page])
    render 'index'
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
    @user.ban = 0
    if @user.save
      sign_in @user
      flash[:succeess] = "Sign up successfully"      
      redirect_to @user
    else
      render 'new'
    end
    
  end

  def ban
    @user = User.find(params[:id])
    action = ""
    if @user.ban == 1
      @user.ban = 0
      action = "unban"
    elsif @user.ban == 0
      @user.ban = 1
      action = "ban"
    end 

    if @user.save(validate: false)
      flash[:success] = "Successfully #{action} user #{@user.name}"
      redirect_to root_url
    else
      flash[:failure] = "Ban failed"
      redirect_to root_url

    end
  end

  def upgrade
    @user = User.find(params[:id])
    level = params[:level]
    @user.seller_level = level

    if @user.save(validate: false)
      flash[:success] = "Successfully upgrade user to #{level} account"
      redirect_to root_url
    else
      flash[:failure] = "Upgrade failed"
      redirect_to root_url

    end
  end

   def read
    @user = User.find(params[:id])
    read = params[:unread]
    @user.unread = read

    if @user.save(validate: false)
      
    else
      flash[:failure] = "Read/unread failed"
      redirect_to root_url

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

  def like?(product)
    likes.find_by_product_id(product.id)
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
