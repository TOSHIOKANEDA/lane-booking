class Order < ApplicationRecord
  
  belongs_to :user
  belongs_to :slot, optional: true
  
  validate :date, if: :date_cannot_be_in_the_past
  validates :user_id, uniqueness: false

  
  def date_cannot_be_in_the_past
    if date < Date.today
      errors.add(:date, ": 過去の日付は使えません")
    end
  end
  

    
end
