class HomeController < ApplicationController
  def top #topにおける裏の処理を担当（モデルに対する処理の命令）
    @user = User.all
  end

  def index
    us = User.all
    personal =Array.new
    num =0
    us.each do |user|
      personal[num] ={'name' => user.name, 'email' => user.email}
      num = num+1
    end
    render:json => personal
  end

  def new
      @user = User.new 
  end

  def create
    name = params[:user][:name]
    email = params[:user][:email]
    User.create(name: name,email: email)
  end
end
