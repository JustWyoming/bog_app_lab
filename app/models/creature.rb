class Creature < ActiveRecord::Base

  validates :name, format: { :with => /^[A-Za-z ]+$/, :message => "Only letters a-z are allowed", :multiline => true }
    validates :name, presence: true, uniqueness: true, case_sensitive: false, numericality: false
  validates :desc, presence: true, length: { minimum: 10, maximum: 255 }
end
