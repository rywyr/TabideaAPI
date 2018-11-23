# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#　データベースにデータを投入するファイル
num=0
array = Array.new
while num <10 do
    array[num] = "aaaa@bbbb"+num.to_s
    num = num + 1
end 
User.create(name: 'master', email: array[0], uuid:'tsubasa',token:'tsubasa96471205')

#Event.create(title:"福岡",password_digest:"abab")
#Event.create(title:"佐賀",password_digest:"adad")
#Event.create(title:"長崎",password_digest:"aeae")

#Userevent.create(user_id:1,event_id:1)
#Userevent.create(user_id:2,event_id:3)
#Userevent.create(user_id:2,event_id:2)
#Userevent.create(user_id:3,event_id:3)
#Userevent.create(user_id:4,event_id:3)
#Userevent.create(user_id:5,event_id:3)


