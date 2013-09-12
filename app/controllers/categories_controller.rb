class CategoriesController < ApplicationController
  before_filter :filter_admin, only: [:index, :new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    
    products = Product.find_by_category_id(params[:category][:parent_id])
    if !products.nil?
      redirect_to root_url, notice: "Cannot create category whom parent has associated products" and return
    end
    parent_category = Category.find(params[:category][:parent_id])
    @category = parent_category.children.create(name: params[:category][:name])
   
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_url, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    products = Product.find_by_category_id(params[:category][:parent_id])
    if !products.nil?
      redirect_to root_url, notice: "Cannot update category whom parent has associated products" and return
    end
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy

    products = Product.find_by_category_id(params[:id])
    if !products.nil?
      redirect_to root_url, notice: "Cannot destroy category which has associated products" and return
    end

    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
