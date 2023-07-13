require_relative '../data_stores/readings.rb'
include ReadingsByDevice

class ReadingsController < ApplicationController
    # GET /readings
    def index
 
        if params[:device_id]
            @readings = ReadingsByDevice.get_readings_by_device(params[:device_id])
        else
            @readings = ReadingsByDevice.get_all_readings
        end
      render json: @readings
    end
  
    # GET /readings/1
    def show
        @readings = []
        render json: @reading
    end
  
    # POST /readings
    def create
        params.require([:id, :readings])
        @readings = ReadingsByDevice.add_readings({
            id: params[:id], 
            readings: params[:readings]
        })

        if @readings.present?
            render json: @readings, status: :created
        else
            render json: ['There was an error recording the readings'], status: 500
        end
    end
  end