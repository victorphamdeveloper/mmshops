class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)", current_user, params[:receiver_id], params[:receiver_id], current_user)
  end

  # GET /messages/1 
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    root = Message.where("sender_id = ? and ancestry = ?", [current_user, params[:receiver_id]], "")
    if root == nil
      @message = current_user.sended_messages.new(receiver_id: params[:receiver_id])
    else
      @message = current_user.sended_messages.new(receiver_id: params[:receiver_id], ancestry: leap)      
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create

    @message = Message.create!(params[:message])

  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
