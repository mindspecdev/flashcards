class Card < ActiveRecord::Base

  attr_accessor :entered_translated_text

  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_cannot_be_translated

  before_create :set_default_review_date

  after_update :update_review_date

  scope :need_review, ->{ where('review_date < ?', DateTime.now) }  
 
  def original_cannot_be_translated
    if original_text.mb_chars.downcase.strip == translated_text.mb_chars.downcase.strip
      errors.add(:original_text, "can't be the same as translated text.")
    end
  end  

  def set_default_review_date
    self.review_date = DateTime.now + 3
  end

  def update_review_date
    self.review_date = DateTime.now + 3
  end

end
