class Company < ActiveRecord::Base
  belongs_to :user
  has_many :csasses, :dependent => :destroy
  has_many :services, through: :csasses
  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :services
  accepts_nested_attributes_for :pictures , :allow_destroy => true #, :reject_if => proc {|attributes| attributes['filename'].blank?}
  acts_as_taggable
  acts_as_taggable_on :districts
  mount_uploader :logo, LogoUploader  
  #districts_list = ['Адмиралтейский', 'Василеостровский', 'Выборгский', 'Калининский', 'Кировский', 'Колпинский', 'Красногвардейский', 'Красносельский', 'Кронштадтский', 'Курортный', 'Московский', 'Невский', 'Петроградский', 'Петродворцовый', 'Приморский', 'Пушкинский', 'Фрунзенский', 'Центральный']
  #services_list = ['', '', '', '', '', '', '', '']
    #districts_list.each do |tag|
      #ActsAsTaggableOn::Tag.new(:name => tag).save
    #end
end