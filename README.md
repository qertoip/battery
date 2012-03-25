# battery

API to your laptop's battery.

Based on the UPower tool available by default on Ubuntu and Debian distros.
Other data sources can be easilly added as plugins.

## Example

    battery = Battery.new
    battery.energy_left          # =>   0.97  (almost fully charged)
    battery.voltage              # =>  12.78  [V]
    battery.charging?            # =>  true
    battery.vendor               # =>  'Panasonic'
    battery.update.energy_left   # =>   0.96  (notice the updated value)

See the acceptance tests for the exhaustive list of examples. Don't fear to look at the code.

## Installation

Add this to your Gemfile:

    gem 'battery'

Then run:

    bundle

## Requirements

 * Ruby 1.9.2

## Running tests

Run all tests:

    bundle exec rake test

Run only functional tests:

    bundle exec rake test:functional

Run only acceptance tests:

    bundle exec rake test:acceptance

## License

Released under the MIT license. Copyright (C) 2012 Piotr 'Qertoip' Włodarek.