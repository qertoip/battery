class AppleSmartBatterySource
  def initialize
    update
  end

  def raw_output
    `ioreg -c AppleSmartBattery -w0 | grep -o '"[^"]*" = [^ ]*' | sed -e 's/= //g' -e 's/"//g' | sort`
  end

  def hashed_output
    output = {}
    raw_output.split("\n").each do |line|
      split_line = line.split(" ")
      output[split_line[0]] = split_line[1]
    end
    output
  end

  def vendor
    fetch('Manufacturer')
  end

  def model
    "N/A"
  end

  def serial
    fetch('BatterySerialNumber')
  end

  def technology
    "N/A"
  end

  def last_update
    DateTime.new
  end

  def has_history?
    false
  end

  def has_stats?
    false
  end

  def present?
    fetch('BatteryInstalled').downcase == 'yes'
  end

  def charging?
    fetch('IsCharging').downcase == 'yes'
  end

  def discharging?
    !charging? && !fully_charged?
  end

  def fully_charged?
    fetch('FullyCharged').downcase == 'yes'
  end

  def energy_left
    fetch('CurrentCapacity').to_f / max_energy_wh
  end

  def energy_left_wh
    fetch('CurrentCapacity').to_f
  end

  def design_max_energy_wh
    fetch('DesignCapacity').to_f
  end

  def max_energy_wh
    fetch('MaxCapacity').to_f
  end

  def voltage
    fetch('Voltage').to_f / 1000
  end

  def update
    @values = hashed_output
  end

  private

  def fetch(key)
    @values[key]
  end
end

