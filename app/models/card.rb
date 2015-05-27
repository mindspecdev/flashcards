class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true

  validate :original_cannot_be_translated
 
  def original_cannot_be_translated
    if original_text.downcase.strip == translated_text.downcase.strip
      errors.add(:original_text, "can't be the same as translated text.")
    end
  end  

  before_create do
    self.review_date = DateTime.now + 3
  end

end
