# -*- coding: UTF-8 -*-

class UPowerDataSource

  attr_accessor :upower_command

  def initialize( options = {} )
    self.upower_command = options[:upower_command] || UPowerCommand.new
    update
  end

  def vendor
    fetch( 'vendor' )
  end

  def model
    fetch( 'model' )
  end

  def serial
    fetch( 'serial' )
  end

  def technology
    fetch( 'technology' )
  end

  def last_update
    fetch( 'updated', :as => DateTime )
  end

  def has_history?
    fetch( 'has history', :as => Boolean )
  end

  def has_stats?
    fetch( 'has statistics', :as => Boolean )
  end

  def present?
    fetch( 'present', :as => Boolean )
  end

  def charging?
    fetch( 'state' ) == 'charging'
  end

  def discharging?
    fetch( 'state' ) == 'discharging'
  end

  def fully_charged?
    fetch( 'state' ) == 'fully-charged'
  end

  def energy_left
    fetch( 'percentage', :as => Float ) / 100.0
  end

  def energy_left_wh
    fetch( 'energy', :as => Float )
  end

  def design_max_energy_wh
    fetch( 'energy-full-design', :as => Float )
  end

  def max_energy_wh
    fetch( 'energy-full', :as => Float )
  end

  def voltage
    fetch( 'voltage', :as => Float )
  end

  def update
    output = upower_command.exec
    first_battery = output.scan( /Device:.*battery_.*\n((.|\n)+)\n(Daemon:|Device:)/ )
    first_battery = first_battery.first.first rescue ''
    first_battery_rows = first_battery.strip.split( /$/ ).map( &:strip ).reject{ |r| !r.include?( ':' ) }
    first_battery_key_value_array = first_battery_rows.map{ |r| r.split( ':', 2 ) }.flatten.map( &:strip )
    @values = Hash[*first_battery_key_value_array]
  end

  private

  class UPowerCommand
    def exec
      `upower -d`
    end
  end

  class Boolean
    def self.parse( s )
      return true if s == 'yes'
      return false if s == 'no'
      nil
    end
  end

  def fetch( key, options = {} )
    type = options[:as] || String
    value = @values[key]
    return nil if value.nil?
    case type.name
      when 'String' then value
      when 'Float' then value.to_f
      when 'DateTime' then DateTime.parse( value )
      when 'UPowerDataSource::Boolean' then Boolean.parse( value )
      when 'UPowerDataSource::Percents' then Percents.parse( value )
      else raise "Unknown type #{type}"
    end
  end

end
