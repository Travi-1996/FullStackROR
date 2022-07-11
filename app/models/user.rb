class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :phone_number
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates_uniqueness_of :phone_number
  validates_format_of :phone_number, :with => AdminType::PHONE_NUMBER_FORMAT,:multiline => true
  validates_format_of :email, :with => AdminType::EMAIL_FORMAT,:multiline => true
  encrypts :password, deterministic: true
  has_one :role
end
