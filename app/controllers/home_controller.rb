class HomeController < ApplicationController

  skip_before_action :verify_authenticity_token
  #top:全データの一覧を表示（デバッグ用）
  #index:全データをjsonで返す
  #new:コントローラー内で用いる変数を定義
  #create:フォームからユーザーを追加（デバッグ用）
  #show:該当するidのデータをjsonで返す
  #jcre:受けとったjsonからデータを追加
  #destroy:該当する名前のデータを削除
  #update:アップデート
  #edit:受け取ったjsonからデータを編集して、アップデート
  # リソースについての記述をします
  resource_description do
    short 'ユーザ情報を扱うエンドポイント'
    path '/home'
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

  def top #デバッグ用一覧表示（後ほど消す）
    @user = User.all
    @event = Event.all
    @userevent = Userevent.all
    @mmo = Mmo.all
  end

  api :GET, '/home/index/:uuid', 'UUIDによって指定されたユーザ一情報（参加しているイベント）を返します'
  # エラーの指定はこのような形で
  error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  $ curl http://localhost:3000/home/index/tsubasa
        {
           "id": 3,
           "name": "Potter",
           "eventList": [
               {
                "id": 3,
                "title": "長崎"
               }
            ]
        }
  EDOC
  def index
    @user = User.find_by(uuid:params[:uuid])
    eve_array = Array.new
    num = 0

    @user.userevent.each do |ue|
      mmo_array = Array.new
      mem_array = Array.new
      eventid = ue.event.id
      
      #MMO配列の作成しました
      j = 0
      Mmo.all.each do |mmoeve| #個々の処理もうちょっと何とかできるはず
        if(mmoeve.event_id == eventid)
          mmo_array[j] = {"viewIndex":mmoeve.viewIndex,"text":mmoeve.text,"positionX":mmoeve.xposition,"positionY":mmoeve.yposition}
          j = j + 1
        end
      end
      
      #メンバー配列の作成
      j = 0
      Userevent.all.each do |eu|
        if(eu.event_id == eventid)
          mem_array[j] =eu.user_id
          j = j + 1 
        end
      end

      #イベント配列の作成
      eve_array[num] = {"id":eventid,"title":ue.event.eventname}
      num= num + 1
    end

    user = {
		  "id": @user.id,
		  "name": @user.name,
      "eventList":eve_array #memberをjsonに追加
	  }
    render:json => user
    #curl http://localhost:3000/home/index/2 -X POST -H "Content-Type: application/json"
    #curl http://quiet-sands-57575.herokuapp.com/home/index/2 -X POST -H "Content-Type: application/json"
  end

  def create #いらん
      name = params[:user][:name]
      email = params[:user][:email]
      uuid = params[:user][:uuid]
      User.create(name: name,email: email,uuid: uuid)
      #curl http://localhost:3000/home/create -X POST -H "Content-Type: application/json" -d "{"user":{"name": "ainz","email": "abs@mail"}}"
  end

  api :POST, '/home/show/:uuid', '指定のUUIDのユーザ情報を返します'
  description '指定のIDのユーザ情報を返します'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $ curl http://localhost:3000/home/show/tsubasa
        Content-Type: application/json; charset=utf-8
        {
          "id": 3,
          "name": "Potter"
        }
  EDOC
  def show
    @user = User.find_by(uuid:params[:uuid])
    user = {
		  "id" => @user.id,
		  "name" => @user.name
	  }
    render:json => user
  end

  api :POST, '/home/usercreate', 'ユーザーを作成'
  description 'POSTされたjsonをもとにユーザーを作成します。'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $ curl http://localhost:3000/home/usercreate
        Content-Type: application/json; charset=utf-8
        {
          "name": "tsubasa",
          "email": "Potter",
          "uuid" : "tsubasa"
        }
  EDOC
  def usercreate#一番最初のユーザー作成
    #json形式でデータが送られrてくることを想定
    #なぜかメソッドが実行されていないようなのでここは一時保留
    @json_request = JSON.parse(request.body.read)
    name = @json_request["name"]
    email = @json_request["email"]
    uuid = @json_request["uuid"]
    User.create(name: name,email: email,uuid: uuid)
    render:json => {"name":name,"email":email,"uuid":uuid}
    #curl https://quiet-sands-57575.herokuapp.com/home/jcre -X POST -H "Content-Type: application/json" -d "{\"user\":{\"name\": \"ichikawa\",\"email\": \"sdfsdf@mail\"}}"
  end
  api :DELETE, '/home/destroy/:name', 'ユーザ情報の消去'
  description '指定の名前ユーザ情報を消去します。'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $ #curl -X DELETE http://localhost:3000/home/destroy/imamura
        
  EDOC
  def destroy
    #名前からユーザーを削除
    @name = params[:name]
    User.find_by(name:params[:name]).destroy

    render:json =>{"name":@name}
    #curl -X DELETE http://localhost:3000/home/destroy/imamura
  end

  api :POST, '/home/edit/:uuid', 'ユーザ情報の編集'
  description '指定のUUIDのユーザ情報を編集します'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $  #curl httphttps://quiet-sands-57575.herokuapp.com/home/edit 
  -X POST -H "Content-Type: application/json" -d 
      {
        "id":5,"name":"izawa",
        "email":"sdfsdfsdfsfsdfsdfsfa",
        "uuid":"izawan"
      }
  EDOC
  def edit 
      @json_request = JSON.parse(request.body.read)#ハッシュ
      @user = User.find(params[:uuid]); #レコード自体が入っている(データベースのデータ)
      @user.update_attributes(name: @json_request["name"])

      render:json =>{"name": @json_request["name"],"email": @json_request["email"],"uuid": @json_request["uuid"]}
      #curl http://localhost:3000/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"unk\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\"}"
      #curl httphttps://quiet-sands-57575.herokuapp.com/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"izawa\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\",\"uuid\":\"izawan\"}"
  end

end
