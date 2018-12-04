class HomeController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  protect_from_forgery :except => [:usercreate,:edit,:destroy,:allusers,:update]
  before_action :authenticate, {only:[:destroy,:edit,:update]}
  before_action :atuhenticatem, {only:[:allusers]}
  
  def show
    @user = User.find_by(uuid:params[:uuid])
    if @user != nil
      user = {
		    id:  @user.id,
        name: @user.name,
        token: @user.token
	    } 
      render:json => user
    else
      response_bad_request
    end 
  end

  def allusers
    @users = User.all
    render:json => @users
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
    #name = @json_request["name"]
    #email = @json_request["email"]
    #uuid = @json_request["uuid"]
    #icon_image = @json_request["icon_image"]
    #@user = User.create(name: params[:name],email: email,uuid: uuid,icon_image: icon_image)
    p user_params
    p "------------------"
    @user = User.new(user_params)
    p @user.valid? 
    p "-------------------"
    p @user.errors.messages
    p "--------------"
    p @user.icon_image
    @user.save!
    user = {
		    "id" => @user.id,
        "name" => @user.name,
        "token" => @user.token
	    } 
    render:json => user
    #render:json => {"name":name,"email":email,"uuid":uuid}
    #curl https://quiet-sands-57575.herokuapp.com/home/jcre -X POST -H "Content-Type: application/json" -d "{\"user\":{\"name\": \"ichikawa\",\"email\": \"sdfsdf@mail\"}}"
  end
  api :DELETE, '/home/destroy/:id', 'ユーザ情報の消去'
  description '指定IDのユーザ情報を消去します。'
  formats ['json']
  error code: 401, description: 'Unauthorized'
  error code: 404, description: 'Not Found'
  error code: 400, description: 'Invalid parameter'

  example <<-EDOC
  $ #curl -X DELETE http://localhost:3000/home/destroy/:id
        
  EDOC
  def destroy
    #IDからユーザーを削除
    @user = User.find(params[:id])
    @user.destroy

    @users = User.all
    render:json => @users
    #curl -X DELETE http://localhost:3000/home/destroy/imamura
  end

  api :POST, '/home/edit/:id', 'ユーザ情報の編集'
  description '指定のIDのユーザ情報を編集します'
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
      }
  EDOC
  def edit 
      @json_request = JSON.parse(request.body.read)#ハッシュ
      @user = User.find(params[:id]); #レコード自体が入っている(データベースのデータ)
      @user.update_attributes(name: @json_request["name"],email: @json_request["email"],uuid: @user.uuid)
      #@user.update_attributes(name: @json_request["name"])
      user = {
        "name" => @user.name
	    } 
    render:json => user
      #curl http://localhost:3000/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"unk\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\"}"
      #curl httphttps://quiet-sands-57575.herokuapp.com/home/edit -X POST -H "Content-Type: application/json" -d "{\"id\":5,\"name\":\"izawa\",\"email\":\"sdfsdfsdfsfsdfsdfsfa\",\"uuid\":\"izawan\"}"
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.errors.empty?
      render json: :ok 
    else
      render json: :bad_request
    end
  end

  def authenticate
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
          auth_user != nil ? true : false
        end
  end

  def atuhenticatem
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
             master = User.find_by(token: ENV['master_key'])
          auth_user != master ? false : true
        end
  end

  private

 
  def user_params
    params.permit(:name,:email,:uuid,:icon_image)
  end
end
