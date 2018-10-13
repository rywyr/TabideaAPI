class EventController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        @json_request = JSON.parse(request.body.read)
        @user = User.find(params[:user_id])
        eventname = @json_request["title"]
        explain = @json_request["explain"]
        @user.event.create(eventname: eventname,explain: explain)

        redirect_to :action => :show, :id => params[:id]
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
        @user_id = params[:user_id]
        @event_id = params[:event_id]
        Userevent.create(user_id: @user_id,event_id: @event_id)
        redirect_to :action => "show"    
    end

    def show
        #イベントに参加後そのユーザーが所属するイベントリストの送信
        @user = User.find(params[:user_id])
        #@event = Event.find(@event_id)

        eve_array = Array.new
        enum = 0
        @user.userevent.each do |ue|
            #イベントに所属するメンバーの配列
            @event = ue.event
            member_array = Array.new
            mnum = 0
            @event.userevent.each do |ue|
                member_array[mnum] = ue.user.id
                mnum = mnum + 1
            end
           eve_array[enum] = {"id":ue.event.id,"title":ue.event.eventname,"member":member_array}
           enum = enum + 1
        end
        render:json=>eve_array

    end
end
