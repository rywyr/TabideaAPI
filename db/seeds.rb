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
#User.create(name: 'Peter', email: array[0])
#User.create(name: 'Patola', email: array[1])
#User.create(name: 'Potter', email: array[2])


#Userevent.create(user_id:1,event_id:1)
#Userevent.create(user_id:2,event_id:3)

#Event.create(eventname:"福岡",explain:"おいしい")
#Event.create(eventname:"佐賀",explain:"鏡山")
#Event.create(eventname:"長崎",explain:"異国")

#Mmo.create(text:"旅行",parent:" ",xposition:0.1,yposition:0.2,event_id:1,viewIndex:0)
#Mmo.create(text:"福岡",parent:1,xposition:0.1,yposition:0.2,event_id:1,viewIndex:1)
Mmo.create(text:"長崎",parent:1,xposition:0.1,yposition:0.2,event_id:3,viewIndex:1)
#Event.create(eventname:"福岡",explain:"おいしい")
#Event.create(eventname:"佐賀",explain:"鏡山")
#Event.create(eventname:"長崎",explain:"異国")
