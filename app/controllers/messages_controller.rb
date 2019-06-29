class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @friend = Friend.find(@message.friend_id)
    @message.user_id = current_user.id
    if !@message.message.nil?
     @message.sentiment = Aylien.check(@message.message)
    end
    respond_to do |format|
      if @message.save

        format.json { render :show, status: :created, location: @message }
        format.js {render :'messages/create'}
        FriendChannel.broadcast_to @friend, @message

      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.js {}
      end
    end

  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      endrender :'messages/create'
    end
    end
    end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_attachment
    @media = Message.new(file_name: params[:file])
    @friend = Friend.find(params[:friend_id].to_i)
    @media.friend_id = @friend.id
    @media.is_attachment = true
    @media.user_id = current_user.id
    if @media.save!
      @media.update(:attachment_content_type=>@media.file_name.content_type)
      respond_to do |format|
        FriendChannel.broadcast_to @friend, @media
        format.html {redirect_to "/chats/shubham"}
        format.json{ render :json => @media }
        format.js {render :'messages/upload_attachment'}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:friend_id, :message)
    end
end
