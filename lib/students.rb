class Student
  attr_accessor :first_name, :last_name, :id_number

  def full_name
    last_name + ", " + first_name
  end  
end