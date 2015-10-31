class PhoneNumber < ActiveRecord::Base
  validates :number, presence: true
  validates :person_id, presence: true
  belongs_to :person
end
