class ProductsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :update, :destroy]
  before_filter :filter_ban, only: [:create, :update, :new]
  before_filter :filter_ban_product, only: [:show, :update, :edit]
  before_filter :seller_or_admin_of_this_product, only:  [:update, :edit, :destroy]

  # GET /products
  # GET /products.json
  def index
    @use_sidebar = true
    @products = Product.where("ban = 0")
    if !params[:category_id].nil?
      @products = @products.where("category_id = ?",params[:category_id])
    elsif !params[:city].nil?
      @products = @products.where("location = ?",params[:city])
    elsif params[:like] == "true"
      @products = current_user.like_products
    elsif !params[:sort_by].nil?
      if params[:sort_by] == "no_of_likes"
        @products = @products.sort{|a,b| b.likes.count <=> a.likes.count }
      elsif params[:sort_by] == "created_at"
        @products = @products.order("created_at DESC")
      elsif params[:sort_by] == "price_low_high"
        @products = @products.order("price ASC")
      elsif params[:sort_by] == "price_high_low"
        @products = @products.order("price DESC")     
      end
    elsif !params[:seller].nil?
      @products = @products.where("user_id = ?",params[:seller])
    elsif params[:category_id].nil? and params[:city].nil? and params[:like] != "true" and params[:sort_by].nil?
      @products = @products.order("created_at DESC")    
    end      

    @products = @products.paginate(page: params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end


  def search
    if !params[:key].nil?
    @products = Product.where("name like '%#{params[:key]}%' and location = ?", current_user.location).paginate(page: params[:page])
    else
      @products = Product.all.paginate(page: params[:page])
    end

    render 'index'
  end
  
  def view_ban_products
    @products = Product.where("ban = 1")
    render 'ban'
  end

  def ban
    @product = Product.find(params[:id])
    action = ""
    if @product.ban == 1
      @product.ban = 0
      action = "unban"
    elsif @product.ban == 0
      @product.ban = 1
      action = "ban"
    end 

    if @product.save(validate: false)
      flash[:success] = "Successfully #{action} product #{@product.name}"
      redirect_to root_url
    else
      flash[:failure] = "Ban failed"
      redirect_to root_url

    end
  end
  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    if (current_user.seller_level == 'normal')
      2.times { @product.product_images.build }
    elsif (current_user.seller_level == 'premium')
      5.times { @product.product_images.build }      
    elsif (current_user.seller_level == 'elite')
      10.times { @product.product_images.build }      
    end

  end

  # GET /products/1/edit
  def edit
    @product = Product.includes(:product_images).find(params[:id])
    
    render :layout => "edit_product"
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.create(params[:product])
    if @product.save
      flash[:success] = "You created a new product"
      redirect_to root_url
    else
      err_message = ""
      @product.errors.full_messages.each do |msg|
        err_message += msg
      end
      flash[:error] = err_message
      redirect_to root_url
    end

  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def seller_or_admin_of_this_product
    @product = Product.find(params[:id])
    if @product.user_id != current_user.id and !is_admin(current_user)
      redirect_to root_url, notice: "You are not admin/owner of this product"
    end    

  end

end
