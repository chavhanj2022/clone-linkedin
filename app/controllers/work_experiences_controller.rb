class WorkExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work_experiences, only: %i[edit update destroy]

  def new
    @work_experience = current_user.work_experiences.new
  end

  def create
    @work_experience = current_user.work_experiences.new(work_experience_params)
    respond_to do |format|
      if @work_experience.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append('work_experience_items', partial: 'work_experiences/work_experience',
                                                                            locals: { work_experience: @work_experience })
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('remote_modal', partial: 'shared/turbo_model',
                                                                    locals: { form_partial: 'work_experiences/form', modal_title: 'Add new work experience' })
        end
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @work_experience.update(work_experience_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("work_experience_item_#{@work_experience.id}",
                                                    partial: 'work_experiences/work_experience', locals: { work_experience: @work_experience })
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('remote_modal', partial: 'shared/turbo_model',
                                                                    locals: { form_partial: 'work_experiences/form', modal_title: 'Edit work experience' })
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      @work_experience.destroy
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("work_experience_item_#{@work_experience.id}") # , partial: 'work_experiences/work_experience', locals: {work_experience: @work_experience}
      end
    end
  end

  private

  def set_work_experiences
    @work_experience = current_user.work_experiences.find(params[:id])
  end

  def work_experience_params
    params.require(:work_experience).permit(:start_date, :currently_working_here, :company, :employment_type,
                                            :location, :location_type, :description, :user_id, :job_title, :end_date)
  end
end
