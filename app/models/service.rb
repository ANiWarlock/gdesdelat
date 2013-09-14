class Service < ActiveRecord::Base
  has_many :csasses, :dependent => :destroy
  has_many :companies, through: :csasses
end