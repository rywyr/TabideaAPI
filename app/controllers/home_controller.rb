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


  def top #デバッグ用一覧表示（後ほど消す）
    @user = User.all
    @event = Event.all
    @userevent = Userevent.all
    @mmo = Mmo.all
  end

  def index #UUIDを受け取ってユーザーの情報を返す
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
      eve_array[num] = {"id":eventid,"title":ue.event.eventname,"member":mem_array,"mmo":mmo_array}
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

  def show
    @user = User.find_by(uuid:params[:uuid])
    user = {
		  "id" => @user.id,
		  "name" => @user.name
	  }
    render:json => user
  end

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

  def destroy
    #名前からユーザーを削除
    @name = params[:name]
    User.find_by(name:params[:name]).destroy

    render:json =>{"name":@name}
    #curl -X DELETE http://localhost:3000/home/destroy/imamura
  end

  def edit 
      @json_request = JSON.parse(request.body.read)#ハッシュ
      @user = User.find(params[:id]); #レコード自体が入っている(データベースのデータ)
      @user.update_attributes(name: @json_request["name"],email: @json_request["email"],uuid: @json_request["uuid"])

      render:json =>{"name": @json_request["name"],"email": @json_request["email"],"uuid": @json_request["uuid"]}
      #curl http://localhost:3000/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"unk\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\"}"
      #curl httphttps://quiet-sands-57575.herokuapp.com/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"izawa\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\",\"uuid\":\"izawan\"}"
  end

end
