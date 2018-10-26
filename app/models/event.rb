class Event < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:eventname]

  has_many :userevent, :dependent => :destroy
  has_many :user, through: :userevent

  # イベント名で検索
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if eventname = conditions.delete(:eventname)
      where(conditions).where(eventname: eventname).first
    else
      where(conditions).first
    end
  end

  # 登録時に email を不要にする
  def email_required?
    false
  end
  def email_changed?
    false
  end
end
