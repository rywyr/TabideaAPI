class MmocontrollerController < ApplicationController
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

  def top
    @mmo = Mmo.all
  end

  def index
    @mmo = Mmo.all
    mmolist = Array.new
    num = 0
    @mmo.each do |mmo|
      mmolist[num] = {'text'=>mmo.text,'xposition'=>mmo.xposition,'yposition'=>mmo.yposition,'parent'=>mmo.parent,'event_id' => mmo.event_id,'viewIndex' => mmo.viewIndex}
      num = num + 1
    end
    render:json => mmolist
  end

  def create
    @mmo = Mmo.create(mmo_params)
  end

  def show
    @id = params[:id]
    @mmo = Mmo.find(params[:id])
    render:json => @mmo
  end

  def eventshow
    @event = Event.find(params[:id])
    mindmap_array = Array.new
    num = 0
    @event.mmo.each do |mm|
      mindmap_array[num] = {
                        'viewIndex':mm.viewIndex,
                        'text':mm.text,
                        'xposition':mm.xposition,
                        'yposition':mm.yposition,
                        'parent':mm.parent,
                        'event_id':mm.event_id,
                      }
      num = num + 1
    end
    mindmap = {
      "mindmap":mindmap_array
    }
    render:json => mindmap
  end

  def jcre
    @json_request = JSON.parse(request.body.read)
    text = @json_request["text"]
    event_id = @json_request["event_id"]
    xposition = @json_request["xposition"]
    yposition = @json_request["yposition"]
    parent = @json_request["parent"]
    viewIndex = @json_request["viewIndex"]
    @mmo = Mmo.create(text:text,event_id:event_id,xposition:xposition,yposition:yposition,parent:parent,viewIndex:viewIndex)
    #curl https://quiet-sands-57575.herokuapp.com/home/jcre -X POST -H "Content-Type: application/json" -d "{\"mindmap\":{\"text\": \"ichikawa\",\"event_id\": \"1\"}}"
  end

  def destroy
    @mmo = Mmo.find(params[:id])
    @mmo.destroy
    #curl -X DELETE http://localhost:3000/home/destroy/imamura
  end

  def edit
    @json_request = JSON.parse(request.body.read)#ハッシュ
      @id = @json_request["id"]
      @mmo = Mmo.find(@id); #レコード自体が入っている(データベースのデータ)
      @user.update_attributes(text: @json_request["text"],xposition: @json_request["xposition"],yposition: @json_request["yposition"],parent: @json_request["parent"],event_id: @json_request["event_id"])
  end

  private
  
    def mmo_params
      params.require(:mmo).permit(:event_id, :text, :xposition, :yposition, :parent, :viewIndex)
    end
end
