require File.expand_path('../rover_mission/plato', __FILE__)
require File.expand_path('../rover_mission/rover', __FILE__)


module RoverMission 

  class Mission
    attr_reader :plato, :rovers, :output 

    def initialize
      @rovers = []
      @output = []
    end

    def create_plato(width, heigth)
      @plato = Plato.new(width, height)
    end

    def add_rover(start, command)
      x, y, code = start.split(' ')
      direction = direction_for_code(code)
      rover = Rover.new
      rover.land(plato, x, y, direction)
      rovers.push({rover: rover, command: command}) 
    end

    def process_output
      rovers.each do |rover_data|
        rover_data[:rover].move(rover_data[:command])
        output << "#{rover_data[:rover].x} #{rover_data[:rover].y} #{rover_data[:rover].direction.to_s}"
      end
    end

    private

    def direction_for_code(code) 
      case code 
      when Direction::NORTH.to_s
        Direction::NORTH
      when Direction::EAST.to_s
        Direction::EAST
      when Direction::WEST.to_s
        Direction::WEST
      when Direction::SOUTH.to_s
        Direction::SOUTH
      else
        raise ArgumentError.new("Bad direction code provided: #{code}, valid codes are N,S,E,W")
      end
    end

  end

end
