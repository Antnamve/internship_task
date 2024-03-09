class SchoolClasses::StudentsController < ApplicationController
  def index
    @students = Student.includes(:school).where(school_id: params[:school_id], class_id: params[:class_id])
    @study_group = @students.first&.study_group
    respond_to do |format|
      format.html {}
      format.json { render json: @students }
    end
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        @student.study_group.increment!(:students_count)
        format.html { redirect_to student_url(@student), notice: "Ученик был успешно добавлен!" }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def student_params
    params.permit(:first_name, :last_name, :surname, :school_id, :class_id, student: [:first_name, :last_name, :surname, :school_id, :class_id])
  end
end