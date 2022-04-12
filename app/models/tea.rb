class Tea < ApplicationRecord
  has_many :tea_subs
  has_many :subscriptions, through: :tea_subs
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :temp
  validates_presence_of :brewtime
end
