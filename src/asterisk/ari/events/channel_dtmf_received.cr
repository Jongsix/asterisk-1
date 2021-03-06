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
require "./event.cr"

module Asterisk
  class ARI
    class Events < Resources
      # DTMF received on a channel.
      #
      # This event is sent when the DTMF ends. There is no notification about the start of DTMF
      struct ChannelDtmfReceived < Event
        # DTMF digit received (0-9, A-E, # or *)
        property digit : String

        # Number of milliseconds DTMF was received
        property duration_ms : Int32

        # The channel on which DTMF was received
        property channel : Channels::Channel
      end
    end
  end
end
