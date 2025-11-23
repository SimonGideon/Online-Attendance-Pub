# db/seeds.rb
puts "Cleaning up existing data..."
# Delete in reverse order of dependencies (child records first)
Attendance.delete_all
StudentsCourse.delete_all
LecturerUnit.delete_all
Student.delete_all
Course.delete_all
Lecturer.delete_all
Administrator.delete_all
puts "Cleanup complete!"

puts "Creating Administrator..."
Administrator.create!(email: "admin@example.com", password: "password", first_name: "Admin", last_name: "User")
puts "Administrator created!"

# Create 300 Lecturers
puts "Creating 300 Lecturers..."
lecturers = []
300.times do |i|
  lecturers << Lecturer.create!(
    name: "Lecturer #{i + 1}",
    service_number: "L#{1000 + i + 1}",
    phone: "#{1000000000 + i}",
    work_email: "lecturer#{i + 1}@example.com",
    email: "lecturer#{i + 1}@example.com",
    password: "password123",
  )
end
puts "300 Lecturers created!"

# Create 300 Courses
puts "Creating 300 Courses..."
courses = []
300.times do |i|
  courses << Course.create!(
    course_name: "Course #{i + 1}",
    course_code: "C#{1000 + i + 1}",
    lecturer_id: lecturers.sample.id
  )
end
puts "300 Courses created!"

# Create 300 Students
puts "Creating 300 Students..."
students = []
300.times do |i|
  students << Student.create!(
    name: "Student #{i + 1}",
    registraion_number: "S#{2000 + i + 1}",
    email: "student#{i + 1}@example.com",
    phone: "#{2000000000 + i}",
    password: "password123",
  )
end
puts "300 Students created!"

# Create 300 Lecturer Units
puts "Creating 300 Lecturer Units..."
lecturer_units = []
300.times do |i|
  lecturer_units << LecturerUnit.create!(
    lecturer: lecturers.sample,
    course: courses.sample
  )
end
puts "300 Lecturer Units created!"

# Create 300 Students Courses (enrollments)
puts "Creating 300 Student Course enrollments..."
students_courses = []
300.times do |i|
  students_courses << StudentsCourse.create!(
    student: students.sample,
    lecturer_unit: lecturer_units.sample
  )
end
puts "300 Student Course enrollments created!"

# Create 300 Attendances
puts "Creating 300 Attendances..."
300.times do |i|
  Attendance.create!(
    students_course: students_courses.sample,
    course_id: courses.sample.id,
    attendance_date: Date.today - rand(1..90).days,
    present: [true, false].sample
  )
end
puts "300 Attendances created!"

puts "\n=== Seeding Complete ==="
puts "Total Administrators: #{Administrator.count}"
puts "Total Courses: #{Course.count}"
puts "Total Lecturers: #{Lecturer.count}"
puts "Total Students: #{Student.count}"
puts "Total Students Courses: #{StudentsCourse.count}"
puts "Total Lecturer Units: #{LecturerUnit.count}"
puts "Total Attendances: #{Attendance.count}"
