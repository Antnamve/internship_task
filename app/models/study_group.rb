class StudyGroup < ApplicationRecord
  self.table_name = 'classes'

  belongs_to :school
  has_many :students

  def name
    "#{self.number} #{self.letter}"
  end
end
