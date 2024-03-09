class StudyGroupsController < ApplicationController
  before_action :set_study_group, only: %i[ show edit update destroy ]

  # GET /study_groups or /study_groups.json
  def index
    @study_groups = StudyGroup.includes(:school)
  end

  # GET /study_groups/1 or /study_groups/1.json
  def show
    @students = Student.all.where(class_id: params[:id])
  end

  # GET /study_groups/new
  def new
    @study_group = StudyGroup.new
  end

  # GET /study_groups/1/edit
  def edit
  end

  # POST /study_groups or /study_groups.json
  def create
    @study_group = StudyGroup.new(study_group_params)

    respond_to do |format|
      if @study_group.save
        format.html { redirect_to study_group_url(@study_group), notice: "Класс был успешно добавлен." }
        format.json { render :show, status: :created, location: @study_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @study_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /study_groups/1 or /study_groups/1.json
  def update
    respond_to do |format|
      if @study_group.update(study_group_params)
        format.html { redirect_to study_group_url(@study_group), notice: "Данные класса были успешно обновлены." }
        format.json { render :show, status: :ok, location: @study_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @study_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /study_groups/1 or /study_groups/1.json
  def destroy
    @study_group.destroy!

    respond_to do |format|
      format.html { redirect_to study_groups_url, notice: "Класс был успешно удалён" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_study_group
      @study_group = StudyGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def study_group_params
      params.require(:study_group).permit(:number, :letter, :students_count, :school_id)
    end
end
