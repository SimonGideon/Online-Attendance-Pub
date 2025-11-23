class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Direct associations must be defined before has_many :through
  has_many :students_courses
  has_one_attached :avatar
  
  # has_many :through associations (defined after the direct associations)
  has_many :lecturer_units, through: :students_courses
  has_many :courses, through: :lecturer_units
  has_many :lecturers, through: :lecturer_units
  has_many :attendances, through: :students_courses
end
