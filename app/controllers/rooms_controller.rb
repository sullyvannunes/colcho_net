class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :require_authenticate, :only => [:user, :edit, :update, :destroy]
  before_action :can_change, :only => [:update]

  PER_PAGE = 10

  # GET /rooms
  # GET /rooms.json
  def index
    @search_query = params[:q]
    rooms = Room.search(@search_query).page(1).per(1)

    @rooms = RoomCollectionPresenter.new(rooms.most_recent, self)
  end
  # GET /rooms/1
  # GET /rooms/1.json
  def show
    room_model = Room.where(slug: params[:id]).first
    @room = RoomPresenter.new(room_model, self)
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.where(slug: params[:id]).first
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = current_user.rooms.build(room_params)
    # byebug
    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    @room = Room.where(slug: params[:id]).first
    respond_to do |format|
      #whitelist dos parametros de :room
      if @room.update_attributes(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.where(slug: params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:title, :location, :description, :picture)
  end

  def can_change
    # @room = Room.find(params[:id])
    @room = Room.where(slug: params[:id]).first
    unless user_signed_in? && @room.user_id == current_user.id
      redirect_to room_path(params[:id]), :notice => 'Quarto não correspondente ao usuário logado'
    end
  end
end
