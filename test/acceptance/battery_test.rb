# -*- coding: UTF-8 -*-

require 'test_helper'

class BatteryTest < ActiveSupport::TestCase

  test '.works fine' do
    battery = Battery.new

    assert_kind_of( Float, battery.energy_left )             # =>    0.97  [means 97%]
    assert_kind_of( Float, battery.energy_left_wh )          # =>   48.34  [Wh]

    assert_kind_of( Float, battery.max_energy_wh )           # =>   56.13  [Wh]
    assert_kind_of( Float, battery.design_max_energy_wh )    # =>   60.00  [Wh]

    assert_kind_of( Float, battery.voltage )                 # =>   12.64  [V]

    battery.charging?
    battery.discharging?
    battery.fully_charged?

    battery.present?
    battery.has_history?
    battery.has_stats?

    assert_kind_of( String, battery.vendor )                 # =>   'Panasonic'
    assert_kind_of( String, battery.model )                  # =>   '42T4793'
    assert_kind_of( String, battery.serial )                 # =>   '8651'
    assert_kind_of( String, battery.technology )             # =>   'lithium-ion'

    assert_kind_of( DateTime, battery.last_update )          # =>   Sun Mar 25 18:51:10 2012

    battery.update.energy_left
  end

end
