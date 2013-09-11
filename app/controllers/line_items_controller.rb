class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @sell_line_items = LineItem.where("seller_id = ?", current_user.id)
    @buy_line_items = LineItem.where("buyer_id = ?", current_user.id)    
        
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id, product.get_seller.id, current_user.id)

    respond_to do |format|
      if @line_item.save
        if params[:buynow] == "true"
          @cart = current_cart
          @cart.line_items.each do |l|
            l.status = "pending"
            l.save
          end
          @cart.destroy
          session[:cart_id] = nil
          
          format.html { redirect_to root_url, notice: 'Ordered successfully.' }
          format.json { render json: @line_item, status: :created, location: @line_item }
        else
          format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
          format.json { render json: @line_item, status: :created, location: @line_item }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to line_items_path, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end
end
