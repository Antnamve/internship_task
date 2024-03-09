class StudentsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_student, only: %i[ show edit update destroy ]
  before_action :set_schools_and_study_groups, only: %i[ new create edit ]
  before_action :require_authentication, only: %i[ destroy ]

  def index
    @students = Student.includes(:school)
  end

  def show
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    begin
      @student = Student.new(student_params)
    rescue
      @student = Student.new(student_params[:student])
    end

    @student.password = '123456'
    
    respond_to do |format|
      if @student.save
        current_token = Token.create student: @student
        @student.study_group.increment!(:students_count)
        format.html { redirect_to student_url(@student), notice: "Ученик был успешно добавлен! Токен ученика: #{current_token.token}" }
        format.json do 
          response.headers['X-Auth-Token'] = current_token.token
          render :show, status: :created, location: @student
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: 405 }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Данные ученика были успешно обновлены." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student.study_group.decrement!(:students_count)
    @student.destroy!
    
    respond_to do |format|
      format.html { redirect_to students_url, notice: "Данные ученика был успешно удалён." }
      format.json { head :no_content }
    end
  end

  private

  def require_authentication
    unless student_signed_in?
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Вы не авторизованы для выполнения данной операции" }
        format.json { render json: { ошибка: 'Вы не авторизованы для выполнения данной операции' }, status: 401 }
      end
    end
  end

  def set_student
    begin
      @student = Student.find(params[:id])
    rescue
      render json: { ошибка: 'Некорректная авторизация' }, status: 400
    end
  end

  def set_schools_and_study_groups
    @schools = School.all
    @study_groups = StudyGroup.all
  end

  def student_params
    params.permit(:first_name, :last_name, :surname, :class_id, :school_id, :email, :password, student: [:first_name, :last_name, :surname, :school_id, :class_id])
  end
end
