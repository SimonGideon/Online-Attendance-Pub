Trestle.resource(:courses) do
  menu do
    item :courses, icon: "fas fa-book"
  end

  # Customize the table columns shown on the index view.
  table do
    column :course_name
    column :course_code
    column :lecturer do |course|
      course.lecturer&.name || 'N/A'
    end
    column :students, header: "Total Students" do |course|
      course.lecturer_units.joins(:students_courses).distinct.count('students_courses.id')
    end
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  form do |course|
    text_field :course_name
    text_field :course_code
    select :lecturer_id, Lecturer.all.map { |l| [l.name, l.id] }, { include_blank: true }
  end

  # Show page with detailed information
  controller do
    def show
      @course = admin.find_instance(params)
      @lecturer_units = @course.lecturer_units.includes(:lecturer)
      @students = StudentsCourse.joins(:lecturer_unit).where(lecturer_units: { course_id: @course.id }).includes(:student).distinct
      @attendances = Attendance.where(course_id: @course.id).includes(:students_course)
    end
  end

  # Custom show view
  routes do
    get :show, on: :member
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  params do |params|
    params.require(:course).permit(:course_name, :course_code, :lecturer_id)
  end
end
