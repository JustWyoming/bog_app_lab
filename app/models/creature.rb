class Creature < ActiveRecord::Base

has_and_belongs_to_many :tags

  validates :name, format: { :with => /^[A-Za-z ]+$/, :message => "Only letters a-z are allowed", :multiline => true }
    validates :name, presence: true, uniqueness: true, case_sensitive: false, numericality: false
  validates :desc, presence: true, length: { minimum: 10, maximum: 255 }
end
