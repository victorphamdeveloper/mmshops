class FlagsController < ApplicationController
  before_filter :filter_admin, only: :index
  def index
    @flags = Flag.all
  end


  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(params[:flag])
    @product = Product.find_by_id(params[:flag][:product_id])

    respond_to do |format|
      if @flag.save
        format.html { redirect_to :back, notice: 'Flagged this product as inappropriate.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /flags/1
  # PUT /flags/1.json
  def update
    @flag = Flag.find(params[:id])

    respond_to do |format|
      if @flag.update_attributes(params[:flag])
        format.html { redirect_to @flag, notice: 'Flag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag = Flag.find(params[:id])
    @product = Product.find_by_id(@flag.product_id)

    @flag.destroy

    respond_to do |format|
      format.html { redirect_to flags_url }
      format.js
    end
  end
end
