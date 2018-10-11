class SeedFlatUpdatesController < ApplicationController
  before_action :set_seed_flat_update, only: [:show, :edit, :update, :destroy]

  # GET /seed_flat_updates
  # GET /seed_flat_updates.json
  def index
    @seed_flat_updates = SeedFlatUpdate.all
  end

  # GET /seed_flat_updates/1
  # GET /seed_flat_updates/1.json
  def show
  end

  # GET /seed_flat_updates/new
  def new
    @seed_flat_update = SeedFlatUpdate.new
  end

  # GET /seed_flat_updates/1/edit
  def edit
  end

  # POST /seed_flat_updates
  # POST /seed_flat_updates.json
  def create
    @seed_flat_update = SeedFlatUpdate.new(seed_flat_update_params)

    respond_to do |format|
      if @seed_flat_update.save
        format.html { redirect_to controller: "dashboards", action: "pipeline", notice: 'Seed flat update was successfully created.' }
        format.json { render :show, status: :created, location: @seed_flat_update }
      else
        format.html { render :new }
        format.json { render json: @seed_flat_update.errors, status: :unprocessable_entity }
      end
    end
    #redirect_to controller: "dashboards", action: "pipeline"
  end

  def transplant
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
  end

  def transplant_to_sue
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
    @origin_system_id = @seed_flat.current_system_id
    @destination_system_id = System.where(system_name: "SUE")[0].id
    @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
    @seed_flat.update(current_system_id: @destination_system_id)
    redirect_back(fallback_location: root_path)
  end

  def transplant_to_naga
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
    @origin_system_id = @seed_flat.current_system_id
    @destination_system_id = System.where(system_name: "NAGA")[0].id
    @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
    @seed_flat.update(current_system_id: @destination_system_id)
    redirect_back(fallback_location: root_path)
  end

  def transplant_to_rezha
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
    @origin_system_id = @seed_flat.current_system_id
    @destination_system_id = System.where(system_name: "REZHA")[0].id
    @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
    @seed_flat.update(current_system_id: @destination_system_id)
    redirect_back(fallback_location: root_path)
  end

  def transplant_to_littlefoot
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
    @origin_system_id = @seed_flat.current_system_id
    @destination_system_id = System.where(system_name: "LITTLE FOOT")[0].id
    @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
    @seed_flat.update(current_system_id: @destination_system_id)
    redirect_back(fallback_location: root_path)
  end

  def transplant_to_dumbo
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
    @origin_system_id = @seed_flat.current_system_id
    @destination_system_id = System.where(system_name: "DUMBO")[0].id
    @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
    @seed_flat.update(current_system_id: @destination_system_id)
    redirect_back(fallback_location: root_path)
  end

  def transplant_to_livestorage
    @seed_flat_update = SeedFlatUpdate.new
    @seed_flat = SeedFlat.find(params[:flat])
    @origin_system_id = @seed_flat.current_system_id
    @destination_system_id = System.where(system_name: "live storage").where(room_id: @seed_flat.room_id)[0].id
    @seed_flat_update.update(seed_flat_id: @seed_flat.id, update_type: "transplant", update_datetime: Time.now, origin_system_id: @origin_system_id, destination_system_id: @destination_system_id)
    @seed_flat.update(current_system_id: @destination_system_id)
    redirect_back(fallback_location: root_path)
  end

  # PATCH/PUT /seed_flat_updates/1
  # PATCH/PUT /seed_flat_updates/1.json
  def update
    respond_to do |format|
      if @seed_flat_update.update(seed_flat_update_params)
        format.html { redirect_to @seed_flat_update, notice: 'Seed flat update was successfully updated.' }
        format.json { render :show, status: :ok, location: @seed_flat_update }
      else
        format.html { render :edit }
        format.json { render json: @seed_flat_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seed_flat_updates/1
  # DELETE /seed_flat_updates/1.json
  def destroy
    @seed_flat_update.destroy
    respond_to do |format|
      format.html { redirect_to seed_flat_updates_url, notice: 'Seed flat update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seed_flat_update
      @seed_flat_update = SeedFlatUpdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seed_flat_update_params
      params.require(:seed_flat_update).permit(:seed_flat_id, :update_type, :update_datetime, :origin_system_id, :destination_system_id, :notes)
    end
end
