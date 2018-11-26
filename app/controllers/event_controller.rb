class EventController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  protect_from_forgery :except => [:create,:index,:join,:show,:destroy,:auth,:invitation,:auth,:withdrawal]
  before_action :authenticate, {only:[:create,:index,:join,:show,:destroy,:auth,:invitation,:withdrawal]}

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
        @event = @user.event.create(title: title,creator: @user.id)
        event = {
		  "id" => @event.id,
          "title" => @event.title,
          "creator" => @user.name
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
            eventlist[num] = {"id":ev.id,"title":ev.title,"creator":ev.creator}
            num = num + 1
        end
        render:json => eventlist
    end
    api :GET, '/:token/:user_id', 'イベントへの参加'
    description 'invitationにより作成されたURLへとGETすることでイベントへと参加し、参加したイベント情報を返します。'
    formats ['json']
    error code: 401, description: 'Unauthorized'
    error code: 404, description: 'Not Found'
    error code: 400, description: 'Invalid parameter'

     example <<-EDOC
     $ curl http://localhost:3000/:token/:user_id
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
    #def join #ユーザーがイベントに参加する処理
    #    @json_request = JSON.parse(request.body.read)
    #    @user_id = params[:user_id]
    #    @event_id = params[:event_id]
    #    password = @json_request[:password]
    #    @event = Event.find(params[:event_id])
    #    if  @event.authenticate(params[:password])
    #      Userevent.create(user_id: @user_id,event_id: @event_id)
    #      redirect_to :action => "show"
    #    else
    #      response_unauthorized(:event, :jon)
    #    end
    #end
    def join
        @token = Token.where(['expire_at > ?', Time.now]).find_by(uuid: params[:eventtoken])
        if @token.blank?
            response_bad_request
        else
            id = @token.event_id
            #@token.update_attributes(expire_at: Time.now)
            @event = Event.find(id)
            @user = User.find(params[:user_id])
            Userevent.create(user_id: @user.id,event_id: @event.id)
            
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
            @creator = User.find(ue.event.creator)
            eve_array[enum] = {"id":ue.event.id,"title":ue.event.title,"creator":@creator.name,"member":member_array}
            enum = enum + 1
            end
            render:json=>eve_array
        end
    end

    api :GET, '/event/show/:user_id', 'ユーザーが参加するすべてのイベントの表示'
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
             "password":"aaaaaa",
             "member": [
                     1
             ]
         },
         {
             "id": 8,
             "title": "tsubasa",
             "password":"bbbbbbb",
             "member": [
                   1
             ]
         },
        {
            "id": 3,
            "title": "長崎",
            "password":"ccccccc",
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
            @creator = User.find(ue.event.creator)
            eve_array[enum] = {"id":ue.event.id,"title":ue.event.title,"creator":@creator.name,"member":member_array}
            enum = enum + 1
        end
        render:json=>eve_array

    end
  api :DELETE, '/event/destroy/:id', 'イベント情報の消去'
  description '指定IDのイベント情報を消去します。'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $ #curl -X DELETE http://localhost:3000/home/destroy/:id
        
  EDOC
  def destroy
    #IDからイベントを削除
    @event = Event.find(params[:event_id])
    @event.destroy

    @events = Event.all
    render:json => @events
    #curl -X DELETE http://localhost:3000/event/destroy/:event_id
  end
  api :GET, '/event/invitation/:event_id', '招待URLの作成'
  description 'イベントへと招待するためのURLを作成します。'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $ #curl -X GET http://localhost:3000/event/inivitation/:event_id

  EDOC
  def invitation
    @user = User.find(params[:user_id])
    @token = @user.tokens.create(uuid: SecureRandom.uuid, expire_at: 24.hours.since, event_id: params[:event_id])
    originalurl = "tabidea://#{@token.uuid}"
   #originalurl = "http://localhost:3000/event/#{@token.uuid}"
    url = {
          #"url" => bitly_shorten(originalurl)
          "url"  => originalurl
	    }
    render:json => url
  end

  def auth
    #有効期限によるトークンの判断
    @token = Token.where(['expire_at > ?', Time.now]).find_by(uuid: params[:eventtoken])
    if @token.blank?
        response_bad_request
    else
        id = @token.event_id
        #@token.update_attributes(expire_at: Time.now)
        @event = Event.find(id)
        event = {
		       "id" => @event.id,
               "title" => @event.title,
               "creator" => @event.creator
	    }
        render:json => event
    end
  end

  def withdrawal
    @userevent = Userevent.find_by(user_id: params[:user_id],event_id: params[:event_id])
    @userevent.destroy
    @event = Event.find(params[:event_id])
    title = {
        "title" => @event.title
    }
    render:json => title
  end

  def authenticate
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
          auth_user != nil ? true : false
        end
  end

private

    require 'bitly'
 
    def bitly_shorten(url)
      Bitly.use_api_version_3
      Bitly.configure do |config|
        config.api_version = 3
        config.access_token = "1338aaea0666996c77fd606b6261cae9e26b5a63"
      end
      Bitly.client.shorten(url).short_url
    end
end
