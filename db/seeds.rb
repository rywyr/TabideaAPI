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
User.create(name: 'Peter', email: array[0],uuid:'nabe')
User.create(name: 'Patola', email: array[1],uuid:'izawa')
User.create(name: 'Potter', email: array[2],uuid:'tsubasa')


#Event.create(eventname:"福岡",eventpass:"abab")
#Event.create(eventname:"佐賀",eventpass:"adad")
#Event.create(eventname:"長崎",eventpass:"aeae")

#Userevent.create(user_id:1,event_id:1)
#Userevent.create(user_id:2,event_id:3)
#Userevent.create(user_id:2,event_id:2)
#Userevent.create(user_id:3,event_id:3)
#Userevent.create(user_id:4,event_id:3)
#Userevent.create(user_id:5,event_id:3)


