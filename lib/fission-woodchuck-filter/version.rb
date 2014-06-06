module Fission
  module WoodchuckFilter
    # Custom version class
    class Version < Gem::Version
    end
    # Current library version
    VERSION = Version.new('0.1.0')
  end
end
