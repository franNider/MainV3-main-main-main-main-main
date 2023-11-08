class ChequeosController < ApplicationController
  before_action :set_chequeo, only: %i[ show edit update destroy ]

  # GET /chequeos or /chequeos.json
  def index
    @chequeos = Chequeo.all
  end

  # GET /chequeos/1 or /chequeos/1.json
  def show
  end

  # GET /chequeos/new
  def new
    @chequeo = Chequeo.new
  end

  def edit
    @chequeo = Chequeo.find(params[:id])
  end
  
  def update
    @chequeo = current_user.dog.chequeo.find(params[:id])
  
    if @chequeo.update(chequeo_params)
        flash[:notice] = 'Los datos se han modificado correctamente.'
      redirect_to "/dogs/verFichaMedica"
    else
       render :edit, status: :unprocessable_entity
    end 
  end

  # POST /chequeos or /chequeos.json
  def create
    @chequeo = Chequeo.new(chequeo_params)
    @dog = current_user.dog.find(params[:chequeo][:dog_id]) # Asegúrate de que :dog_id esté presente en params
    @chequeo.dog = @dog
    
    respond_to do |format|
      if @chequeo.save
        format.html { redirect_to "/users/show" }
        format.json { render :show, status: :created, location: @chequeo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chequeo.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /chequeos/1 or /chequeos/1.json
  def destroy
    @chequeo.destroy!

    respond_to do |format|
      format.html { redirect_to "/users/show", notice: "El chequeo se elimino correctamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chequeo
      @chequeo = Chequeo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chequeo_params
      params.require(:chequeo).permit(:descripcion, :fecha)
    end
end
