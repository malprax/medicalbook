class PatientsController < ApplicationController
  # before_action

  # GET /patients
  # GET /patients.json
  def index
    # @patients = Patient.all
    @patients = Patient.page(params[:page])
  end
end
