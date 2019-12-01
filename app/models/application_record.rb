class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(title_s, author_s)
    if title_s && author_s
      self.where(['title LIKE ?', "%#{title_s}%"]).where(['author LIKE ?', "%#{author_s}%"])
    elsif title_s
      self.where(['title LIKE ?', "%#{title_s}%"])
    elsif author_s
      self.where(['author LIKE ?', "%#{author_s}%"])
    else
      self.all
    end
  end
end
