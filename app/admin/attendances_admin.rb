Trestle.resource(:attendances) do
  menu do
    item :attendances, icon: "fas fa-chalkboard-teacher"
  end

  # Customize the table columns shown on the index view.
  table do
    column :id
    column :student do |attendance|
      attendance.students_course&.student&.name || "N/A"
    end
    column :course do |attendance|
      attendance.course&.course_name || "N/A"
    end
    column :attendance_date
    column :present do |attendance|
      attendance.present ? "✓ Present" : "✗ Absent"
    end
    column :created_at, align: :center
    actions
  end

  # Show page with detailed information
  controller do
    def show
      @attendance = admin.find_instance(params)
      @students_course = @attendance.students_course
      @student = @students_course&.student
      @lecturer_unit = @students_course&.lecturer_unit
      @course = @attendance.course
      @lecturer = @lecturer_unit&.lecturer
    end
  end

  # Custom show view to display all students for the unit
  routes do
    get :show, on: :member
  end

  # Customize the form fields shown on the new/edit views.
  form do |attendance|
    select :students_course_id, StudentsCourse.all.map { |sc| ["#{sc.student.name} - #{sc.lecturer_unit.course.course_name}", sc.id] }
    select :course_id, Course.all.map { |c| [c.course_name, c.id] }
    date_field :attendance_date
    check_box :present
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  params do |params|
    params.require(:attendance).permit(:students_course_id, :course_id, :attendance_date, :present)
  end
end
