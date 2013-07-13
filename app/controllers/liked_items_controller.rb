class LikedItemsController < ApplicationController
  # GET /liked_items
  # GET /liked_items.json
  def index
    @liked_items = LikedItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @liked_items }
    end
  end

  # GET /liked_items/1
  # GET /liked_items/1.json
  def show
    @liked_item = LikedItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @liked_item }
    end
  end

  # GET /liked_items/new
  # GET /liked_items/new.json
  def new
    @liked_item = LikedItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @liked_item }
    end
  end

  # GET /liked_items/1/edit
  def edit
    @liked_item = LikedItem.find(params[:id])
  end

  # POST /liked_items
  # POST /liked_items.json
  def create
    @liked_item = LikedItem.new(params[:liked_item])

    respond_to do |format|
      if @liked_item.save
        format.html { redirect_to @liked_item, notice: 'Liked item was successfully created.' }
        format.json { render json: @liked_item, status: :created, location: @liked_item }
      else
        format.html { render action: "new" }
        format.json { render json: @liked_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /liked_items/1
  # PUT /liked_items/1.json
  def update
    @liked_item = LikedItem.find(params[:id])

    respond_to do |format|
      if @liked_item.update_attributes(params[:liked_item])
        format.html { redirect_to @liked_item, notice: 'Liked item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @liked_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liked_items/1
  # DELETE /liked_items/1.json
  def destroy
    @liked_item = LikedItem.find(params[:id])
    @liked_item.destroy

    respond_to do |format|
      format.html { redirect_to liked_items_url }
      format.json { head :no_content }
    end
  end
end
