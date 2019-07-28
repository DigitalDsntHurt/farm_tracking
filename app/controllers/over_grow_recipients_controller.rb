class OverGrowRecipientsController < ApplicationController
  before_action :set_over_grow_recipient, only: [:show, :edit, :update, :destroy]

  # GET /over_grow_recipients
  # GET /over_grow_recipients.json
  def index
    @over_grow_recipients = OverGrowRecipient.all
  end

  # GET /over_grow_recipients/1
  # GET /over_grow_recipients/1.json
  def show
  end

  # GET /over_grow_recipients/new
  def new
    @over_grow_recipient = OverGrowRecipient.new
  end

  # GET /over_grow_recipients/1/edit
  def edit
  end

  # POST /over_grow_recipients
  # POST /over_grow_recipients.json
  def create
    @over_grow_recipient = OverGrowRecipient.new(over_grow_recipient_params)

    respond_to do |format|
      if @over_grow_recipient.save
        format.html { redirect_to over_grow_recipients_path, notice: 'Over grow recipient was successfully created.' }
        format.json { render :show, status: :created, location: @over_grow_recipient }
      else
        format.html { render :new }
        format.json { render json: @over_grow_recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /over_grow_recipients/1
  # PATCH/PUT /over_grow_recipients/1.json
  def update
    respond_to do |format|
      if @over_grow_recipient.update(over_grow_recipient_params)
        format.html { redirect_to @over_grow_recipient, notice: 'Over grow recipient was successfully updated.' }
        format.json { render :show, status: :ok, location: @over_grow_recipient }
      else
        format.html { render :edit }
        format.json { render json: @over_grow_recipient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /over_grow_recipients/1
  # DELETE /over_grow_recipients/1.json
  def destroy
    @over_grow_recipient.destroy
    respond_to do |format|
      format.html { redirect_to over_grow_recipients_url, notice: 'Over grow recipient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_over_grow_recipient
      @over_grow_recipient = OverGrowRecipient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def over_grow_recipient_params
      params.require(:over_grow_recipient).permit(:email)
    end
end
