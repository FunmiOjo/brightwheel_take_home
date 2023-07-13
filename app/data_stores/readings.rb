module ReadingsByDevice
    @readings_by_device = Rails.application.config.readings_by_device
    def add_readings(params)
        readings = params[:readings]
        device_id = params[:id]
        readings_to_add = validate_readings(readings, device_id)
        return readings_to_add if readings_to_add.empty?

        if !@readings_by_device[device_id]
            @readings_by_device[device_id] = []
        end
        
        response = []
        readings_to_add.each do |reading|
            new_reading = {timestamp: reading[:timestamp], count: reading[:count]}
            @readings_by_device[device_id].append(new_reading)
            response.append(new_reading)
        end
        
        response
    end

    def get_all_readings()
        @readings_by_device
    end

    def get_readings_by_device(device_id)
        @readings_by_device[device_id]
    end

    def validate_readings(readings, device_id)
        return [] if !readings.respond_to?("each") or readings.empty?

        filtered_readings = readings.filter do |reading|
            is_valid(reading) and is_unique(reading, device_id)
        end
        filtered_readings.uniq { |reading| [reading[:timestamp], reading[:count]] }
    end

    def is_valid(reading)
        reading[:timestamp].present? and reading[:count].present?
    end

    def is_unique(reading, device_id)
        return true if !@readings_by_device[device_id]
        @readings_by_device[device_id].none? do |recorded_reading|
            recorded_reading[:timestamp] == reading[:timestamp] and recorded_reading[:count] == reading[:count]
        end
    end
end


