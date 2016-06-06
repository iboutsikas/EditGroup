class Admin::ParticipantsController < Admin::DashboardController
  before_action :set_participant, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: ParticipantDatatable.new(view_context) }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'admin/initializeForm', locals: { resource: @participant, form_path: "participants/form" } }
    end
  end

  def update
    respond_to do |format|
      if @participant.update(participant_params.except(:person_attributes) ) && @participant.person.update(participant_params[:person_attributes])
        binding.pry
        format.js { render js: 'hide_and_redraw()' }
      else
        format.js { render 'admin/initializeForm', locals: { resource: @participant, form_path: "participants/form" } }
      end
    end
  end

  def destroy
    @participant.destroy
    respond_to do |format|
      format.js { render js: 'redraw_table()'  }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    @participant = Participant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:participant).permit(:title,:administrative_title, :email, person_attributes:[:id, :firstName, :lastName])
  end
end
