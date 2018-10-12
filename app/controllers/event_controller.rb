class EventController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @json_request = JSON.parse(request.body.read)
        @user = User.find(params[:id])
        eventname = @json_request["title"]
        explain = @json_request["explain"]
        @user.event.create(eventname: eventname,explain: explain)

        #イベント作成後、ユーザーが所属するイベントリストの送信
        eve_array = Array.new
        num = 0
        @user.userevent.each do |ue| 
           eve_array[num] = {"title":ue.event.eventname}
           num= num + 1
        end
        render:json=>eve_array
    end

    def index
        @event = Event.all
        eventlist = Array.new
        num = 0
        @event.each do |ev|
            eventlist[num] = {"id":ev.id,"title":ev.eventname,"explain":ev.explain}
            num = num + 1
        end
        render:json => eventlist
    end

    def join #ユーザーがイベントに参加する処理
        @user_id = User.find_by(user_id:params[:user_id])
        @event_id = Event.find_by(event_id:params[:event_id])
        Userevent.create(user_id: @user_id,event_id: @event_id)
    end
end
