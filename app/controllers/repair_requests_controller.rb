class RepairRequestsController < ApplicationController
  before_action :set_repair_request, only: [:show, :edit, :update, :destroy]
  helper_method :disable_close?, :disable_open?

  # GET /repair_requests
  # GET /repair_requests.json
  def index
    if current_user.has_role?(:manager)
      @repair_requests = RepairRequest.all
    else
      @repair_requests = RepairRequest.where(submitter: current_user)
    end
    @repair_requests ||= []
  end

  # GET /repair_requests/1
  # GET /repair_requests/1.json
  def show
  end

  # GET /repair_requests/new
  def new
    @repair_request = RepairRequest.new
  end

  # GET /repair_requests/1/edit
  def edit
  end

  # POST /repair_requests
  # POST /repair_requests.json
  def create
    @repair_request = RepairRequest.new(repair_request_params)
    @repair_request.submitter = current_user

    respond_to do |format|
      if @repair_request.save
        format.html { redirect_to @repair_request, notice: 'Repair request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repair_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @repair_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repair_requests/1
  # PATCH/PUT /repair_requests/1.json
  def update
    @repair_request.responder = current_user if current_user.has_role?(:manager)
    respond_to do |format|
      if @repair_request.update(repair_request_params)
        format.html { redirect_to @repair_request, notice: 'Repair request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repair_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_requests/1
  # DELETE /repair_requests/1.json
  def destroy
    @repair_request.destroy
    respond_to do |format|
      format.html { redirect_to repair_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair_request
      @repair_request = RepairRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repair_request_params
      params.require(:repair_request).permit(:open_date, :close_date, :request_details, :request_response)
    end

    def disable_close?
      !can?(:close_request, RepairRequest) || @repair_request.new_record?
    end

    def disable_open?
      !can?(:open_request, RepairRequest)
    end
end
