class Order < ApplicationRecord
  
  belongs_to :user
  
  validate :date, if: :date_cannot_be_in_the_past
  
  def date_cannot_be_in_the_past
    if date < Date.today
      errors.add(:date, ": 過去の日付は使えません")
    end
  end
    
end
