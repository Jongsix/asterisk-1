#------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using ctiapps/asterisk crystal shard from the
#  Asterisk PBX version 16.5.0.
#
#------------------------------------------------------------------------------
require "./event.cr"

module Asterisk
  class ARI
    class Events < Resource
      # Channel variable changed.
      struct ChannelVarset < Event

        # The variable that changed.
        property variable : String

        # The new value of the variable.
        property value : String

        # The channel on which the variable was set.
        #
        # If missing, the variable is a global variable.
        property channel : Channels::Channel? = nil
      end
    end
  end
end
