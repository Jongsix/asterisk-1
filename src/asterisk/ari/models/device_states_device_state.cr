# ------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using ctiapps/asterisk crystal shard from the
#  Asterisk PBX version 16.6.0.
#
# ------------------------------------------------------------------------------

module Asterisk
  class ARI
    class DeviceStates < Resources
      # Represents the state of a device.
      struct DeviceState
        include JSON::Serializable

        # Name of the device.
        property name : String

        # Device's state
        property state : String
      end
    end
  end
end
