class Student < ActiveRecord::Base
  has_person_name
  has_one_attached :avatar
  belongs_to :study_group, foreign_key: 'class_id'
  belongs_to :school
  has_many :tokens, dependent: :destroy

  before_destroy :decrement_study_group_students_count

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  def full_name
    "#{self.surname} #{self.first_name} #{self.last_name}"
  end
  
  private

  def email_required?
    false
  end

  def password_required?
    false
  end

  def increment_study_group_students_count
    self.study_group.increment!(:students_count)
  end

  def decrement_study_group_students_count
    self.study_group.decrement!(:students_count)
  end
end
