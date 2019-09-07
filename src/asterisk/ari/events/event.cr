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
require "./message.cr"

module Asterisk
  class ARI
    class Events < Resources
      # Base type for asynchronous events from Asterisk.
      abstract struct Event < Message

        # Name of the application receiving the event.
        property application : String

        # Time at which this event was created.
        property timestamp : Time
      end
    end
  end
end
