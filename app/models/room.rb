class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms #一つのルームにいるユーザー数は2人のため、has_manyになる
end
