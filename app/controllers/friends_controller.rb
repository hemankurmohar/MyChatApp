class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    @users = User.where.not(:id=>current_user)

  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add
    if Friend.find_friend_user_id(current_user.id,params[:user_id].to_i).nil?
      Friend.create(:user_1_id=>current_user.id,:user_2_id=>params[:user_id].to_i)
      flash[:notice]="Friend Request has been sent."
    else
      flash[:alert]="Friend Request has already been raised."
    end
    redirect_to "/friends"
  end

  def approve
    friend = Friend.find_friend_user_id(current_user.id,params[:user_id].to_i)
    if !friend.nil?
      Friend.find(friend).update(:approved=>true)
      flash[:notice]="You are friends now.."
    else
      flash[:alert]="Error."
    end
    redirect_to "/friends"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:user_1_id, :user_2_id, :block)
    end
end
