# -*- encoding : utf-8 -*-

require 'forwardable'

class Battery

  extend Forwardable

  attr_accessor :data_source

  def initialize( options = {} )
    self.data_source = options[:data_source] || UPowerDataSource.new
  end

  def_delegators :data_source, :energy_left,
                               :energy_left_wh,
                               :max_energy_wh,
                               :design_max_energy_wh,
                               :voltage,
                               :charging?,
                               :discharging?,
                               :fully_charged?,
                               :present?,
                               :has_history?,
                               :has_stats?,
                               :vendor,
                               :model,
                               :serial,
                               :technology,
                               :last_update             # =>  DateTime of the last refresh

  def update
    data_source.update
    self
  end

end
