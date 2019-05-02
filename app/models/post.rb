class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 200 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validate :clickbait?

  CLICKBAITS = [/Won't Believe/i,/Secret/i,/Top [0-9]*/i,/Guess/i]

  def clickbait?
    if CLICKBAITS.none? { |pat| pat.match title }
      errors.add(:title, "is not clickbait")
    end
  end
end
