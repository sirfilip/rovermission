module RoverMission

  class PlatoLandingError < StandardError;end
  class InvalidMovementError < StandardError;end

  class Plato
    attr_reader :width, :height, :objects


    def initialize(width, height)
      @width = width
      @height = height
      @objects = []
    end


    def land(obj, x, y)
      raise PlatoLandingError.new("Missed the landing plato") unless coordinates_are_on_plato(x, y)
      objects << {:obj => obj, :x => x, :y => y}
    end

    def register_movement(object) 
      raise InvalidMovementError.new("Movement is not allowed!") unless position_is_valid(object)
    end

  private 

    def coordinates_are_on_plato(x, y)
      x >= 0 && x <= width && y >= 0 && y <= height
    end

    def position_is_valid(object)
      #TODO: add rover collision check
      coordinates_are_on_plato(object.x, object.y)
    end

  end



end
