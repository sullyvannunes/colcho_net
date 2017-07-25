class RoomCollectionPresenter
  # delegate :current_page, :total_pages, :limit_value, to: :rooms
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?, to: :@rooms

  attr_accessor :rooms

  def initialize(rooms, context)
    @rooms = rooms
    @context = context
  end

  def to_ary
    @rooms.map do |room|
      RoomPresenter.new(room, @context, false)
    end
  end
end
