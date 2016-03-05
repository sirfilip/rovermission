require 'spec_helper'

require 'rover_mission/plato.rb'

describe RoverMission::Plato do 

  let(:plato) { RoverMission::Plato.new(100, 100) }

  describe '#landing' do 
    it 'can be landed on' do 
      object = stub(:id => 1, :x => 0, :y => 0)
      plato.land(object, 50, 50)
      plato.objects.wont_equal []
    end

    it 'wont allow landing out of the surface' do 
      object = stub(:id => 0, :x => 0, :y => 0)
      err = lambda { 
        plato.land(object, plato.width + 1, plato.height) 
      }.must_raise RoverMission::PlatoLandingError
      err.message.must_equal "Missed the landing plato"
      err = lambda { 
        plato.land(object, plato.width, plato.height + 1) 
      }.must_raise RoverMission::PlatoLandingError
      err.message.must_equal "Missed the landing plato"
    end

    it 'can land on the edge of a plato' do 
      object = stub(:id => 0, :x => 0, :y => 0)
      refute_raises RoverMission::PlatoLandingError do 
        plato.land(object, plato.width, plato.height)
      end
      refute_raises RoverMission::PlatoLandingError do 
        plato.land(object, 0, 0)
      end
      refute_raises RoverMission::PlatoLandingError do 
        plato.land(object, 0, plato.height)
      end
      refute_raises RoverMission::PlatoLandingError do 
        plato.land(object, plato.width, 0)
      end
    end
  end

end
