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
end
