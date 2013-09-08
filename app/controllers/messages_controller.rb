class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  before_filter :signed_in_user
  def index
    @messages = Message.where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)", current_user, params[:receiver_id], params[:receiver_id], current_user)
    if(@messages == nil)
      current_user.conversations.create(sender_id: current_user, receiver_id: params[:receiver_id])
    end

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
    c = Conversation.where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)", current_user, params[:receiver_id], params[:receiver_id], current_user)
    if c == nil
      #Initiate new conversation with this person
      c = current_user.conversations.create(sender_id: current_user, receiver_id: params[:receiver_id])
      c.messages.new(sender_id: current_user, receiver_id: params[:receiver_id])
    else
      c.messages.new(sender_id:current_user, receiver_id: params[:receiver_id])
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    c = Conversation.where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)", current_user, params[:message][:receiver_id].to_i, params[:message][:receiver_id].to_i, current_user)
    
    if c.blank?
      #Initiate new conversation with this person
    
      c = Conversation.create(sender_id: params[:message][:sender_id], receiver_id: params[:message][:receiver_id])
      @message = c.messages.create!(params[:message])
    else
      @message = c.first.messages.create!(params[:message])
    end

    receiver = User.find(params[:message][:receiver_id])
    receiver.unread = 1
    receiver.save(validate: false)
    
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to messages_path(receiver_id: params[:message][:receiver_id]), notice: 'Message was successfully sent.' }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
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
