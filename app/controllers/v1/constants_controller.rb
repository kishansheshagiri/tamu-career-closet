module V1
  class ConstantsController < ApplicationController
    before_action :set_constant, only: [:show, :edit, :update, :destroy]

    # GET /constants
    # GET /constants.json
    def index
      @constants = Constant.all
    end

    # GET /constants/1
    # GET /constants/1.json
    def show
    end

    # GET /constants/new
    def new
      @constant = Constant.new
    end

    # GET /constants/1/edit
    def edit
    end

    # POST /constants
    # POST /constants.json
    def create
      @constant = Constant.new(constant_params)

      respond_to do |format|
        if @constant.save
          format.html { redirect_to @constant, notice: 'Constant was successfully created.' }
          format.json { render :show, status: :created, location: @constant }
        else
          format.html { render :new }
          format.json { render json: @constant.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /constants/1
    # PATCH/PUT /constants/1.json
    def update
      respond_to do |format|
        if @constant.update(constant_params)
          format.html { redirect_to @constant, notice: 'Constant was successfully updated.' }
          format.json { render :show, status: :ok, location: @constant }
        else
          format.html { render :edit }
          format.json { render json: @constant.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /constants/1
    # DELETE /constants/1.json
    def destroy
      @constant.destroy
      respond_to do |format|
        format.html { redirect_to constants_url, notice: 'Constant was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def show_constants
      constants = Constant.all
      json_response({success: true, data: constants}, :ok)
    end

    def update_constant
      @constant = Constant.where(key: params[:key]).first
      if @constant.update(value: params[:value])
        json_response({success: true, message: Message.success_response}, :ok)
      else
        json_response({success:false, message: @constant.errors}, :internal_server_error)
      end
    end

    def createResponseMessage(statusCode,statusMessage)
      response=Hash.new()
      response["statusCode"]=statusCode
      response["statusMessage"]=statusMessage
      return response
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_constant
        @constant = Constant.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def constant_params
        params.require(:constant).permit(:key, :value, :created, :updated)
      end
  end
end