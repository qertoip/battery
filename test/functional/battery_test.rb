# -*- coding: UTF-8 -*-

require 'test_helper'

class BatteryTest < ActiveSupport::TestCase

  class UPowerCommandStub
    def exec
      File.read( File.dirname( __FILE__ ) + '/../fixtures/upower_output.txt' )
    end
  end

  setup do
    data_source = UPowerDataSource.new( :upower_command => UPowerCommandStub.new )
    @battery = Battery.new( :data_source => data_source )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '.energy_left' do
    assert_equal( 0.994219, @battery.energy_left )
  end

  test '.energy_left_wh' do
    assert_equal( 49.87, @battery.energy_left_wh )
  end

  test '.max_energy_wh' do
    assert_equal( 50.16, @battery.max_energy_wh )
  end

  test '.design_max_energy_wh' do
    assert_equal( 56.16, @battery.design_max_energy_wh )
  end

  test '.voltage' do
    assert_equal( 12.504, @battery.voltage )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '.discharging?' do
    refute( @battery.discharging? )
  end

  test '.charging?' do
    refute( @battery.charging? )
  end

  test 'fully_charged?' do
    assert( @battery.fully_charged? )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '.has_history?' do
    assert( @battery.has_history? )
  end

  test '.has_stats?' do
    refute( @battery.has_stats? )
  end

  test '.present?' do
    assert( @battery.present? )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '.vendor' do
    assert_equal( 'Panasonic', @battery.vendor )
  end

  test '.model' do
    assert_equal( '42T4793', @battery.model )
  end

  test '.serial' do
    assert_equal( '8651', @battery.serial )
  end

  test '.technology' do
    assert_equal( 'lithium-ion', @battery.technology )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '.last_update' do
    assert_equal( DateTime.parse( 'Sun Mar 25 18:51:10 2012' ), @battery.last_update )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '.update updates the state' do
    data_source = UPowerDataSource.new( :upower_command => UPowerCommandStub.new )
    battery = Battery.new( :data_source => data_source )
    data_source.expects( :update )
    battery.update
  end

  test '.update returns Battery' do
    assert_kind_of( Battery, @battery.update )
  end

end
