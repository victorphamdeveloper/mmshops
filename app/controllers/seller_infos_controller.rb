class SellerInfosController < ApplicationController
  # GET /seller_infos
  # GET /seller_infos.json
  def index
    @seller_infos = SellerInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @seller_infos }
    end
  end

  # GET /seller_infos/1
  # GET /seller_infos/1.json
  def show
    @seller_info = SellerInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @seller_info }
    end
  end

  # GET /seller_infos/new
  # GET /seller_infos/new.json
  def new
    @seller_info = SellerInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @seller_info }
    end
  end

  # GET /seller_infos/1/edit
  def edit
    @seller_info = SellerInfo.find(params[:id])
  end

  # POST /seller_infos
  # POST /seller_infos.json
  def create
    @seller_info = SellerInfo.new(params[:seller_info])

    respond_to do |format|
      if @seller_info.save
        format.html { redirect_to @seller_info, notice: 'Seller info was successfully created.' }
        format.json { render json: @seller_info, status: :created, location: @seller_info }
      else
        format.html { render action: "new" }
        format.json { render json: @seller_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /seller_infos/1
  # PUT /seller_infos/1.json
  def update
    @seller_info = SellerInfo.find(params[:id])

    respond_to do |format|
      if @seller_info.update_attributes(params[:seller_info])
        format.html { redirect_to @seller_info, notice: 'Seller info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @seller_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seller_infos/1
  # DELETE /seller_infos/1.json
  def destroy
    @seller_info = SellerInfo.find(params[:id])
    @seller_info.destroy

    respond_to do |format|
      format.html { redirect_to seller_infos_url }
      format.json { head :no_content }
    end
  end
end
