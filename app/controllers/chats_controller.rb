class ChatsController < ApplicationController
  def show
    #BさんのUser情報を取得
    @user = User.find(params[:id])
    #user_roomsテーブルのuser_idがcurrennt_userのレコードのroom_idを配列で取得
    rooms = current_user.user_rooms.pluck(:room_id)
    #user_idがBさん(@user)で、room_idがcurrennt_userの属するroom_id(配列)となるuser_roomsテーブルのレコードを取得して、user_room変数に格納
    #これによって、cuttent_userとBさんに共通のroom_idが存在していれば、その共通のroom_idとBさんのuser_idがuser_rooms変数に格納される(1レコード)存在しなければ、nilになる
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      #user_roomsに紐づくroomテーブルのレコードを@roomに格納
      @room = user_rooms.room
    else
      #roomのidを採番
      @room = Room.new
      @room.save
      #採番したroomのidを使って、user_roomsのレコードを2人分(current_user用、Bさん用)作る(=current_userとBさんに共通のroom_idを作る)
      #current_userのcurrent_user.idをuser_idとして、@room.idをroom_idとしてUserRoomモデルのカラムに保存(1レコード)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      #Bさんの@user.idをuser_idとして、@room.idをroom_idとして、UserRoomモデルのカラムに保存(1レコード)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    #roomに紐づくchatsテーブルのレコードを@hcatsに格納
    @chats = @room.chats
    #form_withでチャットを送信する際に必要なからのインスタンス
    #ここでroom.idを@chatに代入しておかないと、form_withで記述するroom_idに値が渡らない
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chat.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end


end
