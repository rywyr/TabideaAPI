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


  def top #topにおける裏の処理を担当（モデルに対する処理の命令）
    @user = User.all
    @event = Event.all
    @userevent = Userevent.all
  end

  def index #ユーザーの情報を返す
    @user = User.find(params[:uuid])
    eve_array = Array.new
    num = 0
    @user.userevent.each do |ue| 
      eve_array[num] = {"id":ue.event.id,"title":ue.event.eventname,"member":[1,2,3]}
       num= num + 1
    end
    personal = {
		  "id": @user.id,
		  "name": @user.name,
		  "eventList":eve_array
	}
    render:json => personal
  #curl http://localhost:3000/home/index/2 -X POST -H "Content-Type: application/json"
  end

  def new
      @user = User.new 
  end

  def create
      name = params[:user][:name]
      email = params[:user][:email]
      User.create(name: name,email: email)
    #else
      #para = JSON.parse(params)
      #name = para[:user][:name]
      #email = para[:user][:email]
      #User.create(name: name,email: email)
      #curl http://localhost:3000/home/create -X POST -H "Content-Type: application/json" -d "{"user":{"name": "ainz","email": "abs@mail"}}"
  end

  def show
    @id = params[:id]
    @user = User.find(params[:id])
    render:json => @user
  end

  def jcre
    @json_request = JSON.parse(request.body.read)
    name = @json_request["name"]
    email = @json_request["email"]
    User.create(name: name,email: email)
    #curl https://quiet-sands-57575.herokuapp.com/home/jcre -X POST -H "Content-Type: application/json" -d "{\"user\":{\"name\": \"ichikawa\",\"email\": \"sdfsdf@mail\"}}"
  end

  def destroy
    @name = params[:name]
    User.find_by(name:params[:name]).destroy
    #curl -X DELETE http://localhost:3000/home/destroy/imamura
  end

  def edit
      @json_request = JSON.parse(request.body.read)#ハッシュ
      id = @json_request["id"]
      @user = User.find(id); #レコード自体が入っている(データベースのデータ)
      @user.update_attributes(name: @json_request["name"],email: @json_request["email"],uuid: @json_request["uuid"])
      #curl http://localhost:3000/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"unk\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\"}"
  end





  

end