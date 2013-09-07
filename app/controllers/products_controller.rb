class ProductsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :update, :destroy]
  before_filter :filter_seller, only: [:create, :update]
  before_filter :seller_of_this_product, only:  [:update, :edit, :destroy]
  # GET /products
  # GET /products.json
  def index
    if !params[:category_id].nil?
      @products = Product.where("category_id = ?",params[:category_id]).paginate(page: params[:page])
    elsif !params[:city].nil?
      @products = Product.where("location = ?",params[:city]).paginate(page: params[:page])
    elsif params[:like] == "true"
      @products = current_user.like_products.paginate(page: params[:page])
    else
      @products = Product.order("created_at DESC").paginate(page: params[:page], per_page: 12)  
    end      

    if !params[:sort_by].nil?
      if params[:sort_by] == "no_of_likes"
        @products = @products.sort{|a,b| b.likes.count <=> a.likes.count }.paginate(page: params[:page], per_page: 10)  
      elsif params[:sort_by] == "created_at"
        @products = @products.order("created_at DESC")
      elsif params[:sort_by] == "price_low_high"
        @products = @products.order("price ASC")
      elsif params[:sort_by] == "price_high_low"
        @products = @products.order("price DESC")        
      end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
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
    render layout: "new_product"

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
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def seller_of_this_product
    @product = Product.find(params[:id])
    unless @product.user_id == current_user.id
      redirect_to root_url, notice: "You are not owner of this product"
    end    
  end

end
