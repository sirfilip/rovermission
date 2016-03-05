require 'spec_helper'
require 'rover_mission/rover'

describe RoverMission::Rover do
  let (:plato) { stub(:width => 100, :height => 100, :land => nil, :register_movement => nil) }


  describe 'new rover' do

    let(:new_rover) { RoverMission::Rover.new }

    it 'has unique identifier' do 
      new_rover.serialnumber.wont_be_nil
    end

    it 'has no location unless landed somewhere' do 
      new_rover.x.must_equal RoverMission::LOCATION_UNKNOWN
      new_rover.y.must_equal RoverMission::LOCATION_UNKNOWN
      new_rover.direction.must_equal RoverMission::DIRECTION_UNKNOWN
    end


  end


  describe '#landing' do 

    let(:rover) { RoverMission::Rover.new }

    it 'receives a location' do 
      rover.land(plato, {x: 0, y: 0, direction: RoverMission::Direction::EAST})
      rover.x.must_equal 0
      rover.y.must_equal 0
      rover.direction.must_equal RoverMission::Direction::EAST
    end


  end


  describe '#moving' do 
    let(:rover) { RoverMission::Rover.new }

    it 'cannont move unless he is landed' do 
      err = lambda { rover.move("LSD") }.must_raise RoverMission::MovementError  
      err.message.must_equal "Movement aborted! Rover has not landed yet"
    end

    describe 'rotating' do
      let(:rover) { RoverMission::Rover.new } 

      it 'moves left when he receives L' do 
        rover.land(plato, {x: 0, y: 0, direction: RoverMission::Direction::NORTH})
        rover.move("L")
        rover.direction.must_equal RoverMission::Direction::WEST
        rover.move("L")
        rover.direction.must_equal RoverMission::Direction::SOUTH
        rover.move("L")
        rover.direction.must_equal RoverMission::Direction::EAST
        rover.move("L")
        rover.direction.must_equal RoverMission::Direction::NORTH
      end

      it 'moves right when he receives R' do 
        rover.land(plato, {x: 0, y: 0, direction:  RoverMission::Direction::NORTH})
        rover.move("R")
        rover.direction.must_equal RoverMission::Direction::EAST
        rover.move("R")
        rover.direction.must_equal RoverMission::Direction::SOUTH
        rover.move("R")
        rover.direction.must_equal RoverMission::Direction::WEST
        rover.move("R")
        rover.direction.must_equal RoverMission::Direction::NORTH
      end
    end

    describe 'moving in front' do 
      let(:rover) { RoverMission::Rover.new } 

      it 'moves in the right direction when it receives M' do 
        rover.land(plato, {x: 0, y: 0, direction: RoverMission::Direction::NORTH})
        rover.move("M")
        rover.y.must_equal 1 
      end
    end

  end

end
