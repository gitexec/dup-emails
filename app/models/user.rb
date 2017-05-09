class User < ActiveRecord::Base
  has_many :email_collection
  accepts_nested_attributes_for :email_collection, allow_destroy: true
end
