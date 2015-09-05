class Team
  attr_accessor :name, :students

  def initialize(name)
    @name = name
    @students = []
  end

  def print_students
    @students.each do |student|
      puts student.full_name
    end
  end 

  def add_student(id_number, first_name, last_name)
    student = Student.new
    student.id_number = id_number
    student.first_name = first_name
    student.last_name = last_name
    @students << student 
  end
end