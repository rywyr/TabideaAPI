class EventController < ApplicationController
    skip_before_action :verify_authenticity_token
    # リソースについての記述をします
  resource_description do
    short 'イベント情報を扱うエンドポイント'
    path '/event'
    formats [:json]          # Suppoeted Formats に該当
    api_versions 'public'    # APIのバージョン

    description <<-EOS
      ## エンドポイントの説明
       ユーザー情報を扱います。
          Headline: <%= headline %>
          First name: <%= person.first_name %>
       このAPIを使うときは、このヘッダをつけてね、とか。
       apipieでのドキュメントの記載方法は、apipie-railsのspecの下にある
       spec用のspec/dummyを見るとよくわかります。
    EOS
  end

    api :POST, '/event/create/:user_id', 'イベントの作成'
    description 'pathのユーザーID、そしてPOSTされたjsonをもとにイベントを作成し、作成したイベント情報を返します。'
    formats ['json']
    error code: 401, description: 'Unauthorized'
    error code: 404, description: 'Not Found'
    error code: 400, description: 'Invalid parameter'

     example <<-EDOC
     $ curl http://localhost:3000/event/create
        Content-Type: application/json; charset=utf-8
        {
          "title": "長崎",
          "eventpass": "Potter",
        }
    EDOC
    def create #ユーザーが新しいイベントを追加
        @json_request = JSON.parse(request.body.read)
        @user = User.find(params[:user_id])
        title = @json_request["title"]
        password = SecureRandom.hex
        @event = @user.event.create(title: title,password_digest: password)

        event = {
		  "id" => @event.id,
          "title" => @event.title,
          "password" => @event.password_digest
	    }
         render:json => event       
    end
    api :GET, '/event/index', 'イベントの一覧表示'
    description 'すべてのイベント情報を返します。'
    formats ['json']
    error code: 401, description: 'Unauthorized'
    error code: 404, description: 'Not Found'
    error code: 400, description: 'Invalid parameter'

     example <<-EDOC
     $ curl http://localhost:3000/event/index
        {
          "id": "1",
          "title": "長崎"
          "eventpass": "Potter",
        }
    EDOC
    def index
        @event = Event.all
        eventlist = Array.new
        num = 0
        @event.each do |ev|
            eventlist[num] = {"id":ev.id,"title":ev.title,"eventpass":ev.password_digest}
            num = num + 1
        end
        render:json => eventlist
    end
    api :GET, '/event/join/:user_id/:event_id', 'イベントへの参加'
    description 'pathの情報をもとにイベントへと参加し、参加したイベント情報を返します。'
    formats ['json']
    error code: 401, description: 'Unauthorized'
    error code: 404, description: 'Not Found'
    error code: 400, description: 'Invalid parameter'

     example <<-EDOC
     $ curl http://localhost:3000/event/join/:user_id/:event_id
        [
             {
                 "id": 1,
                 "title": "福岡",
                 "member": [
                          1
                 ]
        },
            {
                "id": 8,
                "title": "tsubasa",
                "member": [
                        1
                ]
        },
            {
                "id": 3,
                "title": "長崎",
                "member": [
                        2,
                        3,
                        4,
                        5,
                        1
                ]
            }
        ]
    EDOC
    def join #ユーザーがイベントに参加する処理
        @user_id = params[:user_id]
        @event_id = params[:event_id]
        Userevent.create(user_id: @user_id,event_id: @event_id)
        
        redirect_to :action => "show"    
    end

    api :GET, '/event/join/:user_id', 'ユーザーが参加するすべてのイベントの表示'
    description 'pathの情報をもとにユーザーを探し、そのユーザーが参加するイベント情報を返します。'
    formats ['json']
    error code: 401, description: 'Unauthorized'
    error code: 404, description: 'Not Found'
    error code: 400, description: 'Invalid parameter'

     example <<-EDOC
     $ curl http://localhost:3000/event/join/:user_id
        [
         {
             "id": 1,
             "title": "福岡",
             "member": [
                     1
             ]
         },
         {
             "id": 8,
             "title": "tsubasa",
             "member": [
                   1
             ]
         },
        {
            "id": 3,
            "title": "長崎",
            "member": [
                    2,
                    3,
                    4,
                    5,
                    1
            ]
        }
        ]
    EDOC
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
           eve_array[enum] = {"id":ue.event.id,"title":ue.event.title,"member":member_array}
           enum = enum + 1
        end
        render:json=>eve_array

    end
end
