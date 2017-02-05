class PatientsController < ApplicationController
  load_and_authorize_resource
  # before_action

  # GET /patients
  # GET /patients.json
  def index
    # @patients = Patient.all
    @patients = @patients.page(params[:page])
  end
end
