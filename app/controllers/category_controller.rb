class CategoryController < ApplicationController
  protect_from_forgery :except => [:create,:show,:destroy]
  before_action :authenticate, {only:[:create,:show,:destroy]}
  def show
    @event = Event.find(params[:event_id])
    category_array = Array.new
    cnum = 0
    @event.eventcategory.each do |ec|
      @category = ec.category
      category_array[cnum] = {"name":ec.category.name, "color":ec.category.color}
      cnum = cnum + 1
    end
    categoryevent = {
      id: @event.id,
      category: category_array
    }
    render:json => categoryevent
  end

  def create
    @json_request = JSON.parse(request.body.read)
    @event = Event.find(params[:event_id])
    @category = @event.category.create(name: @json_request["name"],color: @json_request["color"])
    category = {
		  "id" => @category.id,
      "name" => @category.name,
      "color" => @category.color
	  }
    render:json => category    
  end

  def destroy
    @category = Category.find(params[:category_id])
    cname = @category.name
    @category.destroy

    category = {
      "name" => cname
    }
    render:json => category
  end

  def edit
    @category = Category.find(params[:category_id])
    @json_request = JSON.parse(request.body.read)
    @category.update_attributes(name: @json_request["name"],color: @json_request["color"])
    category = {
      name: @category.name,
      color: @category.color
    }
    render:json => category
  end


  def authenticate
        authenticate_or_request_with_http_token do |token,options|
          auth_user = User.find_by(token: token)
          auth_user != nil ? true : false
        end
  end
end
