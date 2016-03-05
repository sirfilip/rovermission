require 'securerandom'

module RoverMission
  
  module Direction
    def self.rotate_left(direction)
      case direction 
      when NORTH
        WEST
      when WEST
        SOUTH
      when SOUTH
        EAST
      when EAST
        NORTH
      end
    end

    def self.rotate_right(direction)
      case direction
      when NORTH
        EAST
      when EAST
        SOUTH
      when SOUTH
        WEST
      when WEST
        NORTH
      end
    end
  
    class Base
      attr_reader :x, :y

      def initialize(x, y) 
        @x = x
        @y = y
      end

      def ==(other) 
        self.x == other.x && self.y == other.y
      end

      def to_s
        case self 
        when NORTH
          "N"
        when SOUTH
          "S"
        when WEST
          "W"
        when EAST
          "E"
        else
          "LOCATION UNKNOWN"
        end
      end
    end

    # assuming that the 0,0 is in the lower left corner
    EAST = Base.new(1, 0)
    WEST = Base.new(-1, 0)
    NORTH = Base.new(0, 1)
    SOUTH = Base.new(0, -1)
    UNKNOWN = Base.new(nil, nil)
  end

  class LOCATION_UNKNOWN; end
  DIRECTION_UNKNOWN = Direction::UNKNOWN

  class MovementError < StandardError; end

  class Rover
    attr_reader :serialnumber, :x, :y, :direction, :plato

    def initialize
      @serialnumber = SecureRandom.uuid
      @x = LOCATION_UNKNOWN
      @y = LOCATION_UNKNOWN
      @direction = DIRECTION_UNKNOWN
      @plato = nil
    end

    def move(commands) 
      raise MovementError.new("Movement aborted! Rover has not landed yet") unless has_landed?  
      commands.split('').each do |c| 
        react_on(c)
      end
    end

    def land(plato, position) 
      @x = position[:x]
      @y = position[:y]
      @direction = position[:direction]
      @plato = plato 
      plato.land(self, position[:x], position[:y])
    end


    private 
    def has_landed? 
      x != LOCATION_UNKNOWN && y != LOCATION_UNKNOWN && direction != DIRECTION_UNKNOWN 
    end

    def react_on(command)
      case command 
      when 'L'
        @direction = Direction.rotate_left(self.direction)
      when 'R'
        @direction = Direction.rotate_right(self.direction)
      when 'M'
        @x += self.direction.x
        @y += self.direction.y
        plato.register_movement(self)
      end
    end

  end


end
