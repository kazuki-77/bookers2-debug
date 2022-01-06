class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  #user_roomsテーブルはusersテーブルとroomsテーブルの中間テーブルです。
  #外部キーとしてuser_idとroom_idを持っています。
end
