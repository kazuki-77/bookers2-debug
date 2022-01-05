class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
#user_roomsテーブルはusersテーブルとroomsテーブルの中間テーブルです。
#外部キーとしてuser_idとroom_idを持っています。