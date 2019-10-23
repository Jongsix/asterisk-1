#------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using ctiapps/asterisk crystal shard from the
#  Asterisk PBX version 16.6.0.
#
#------------------------------------------------------------------------------
require "./event.cr"

module Asterisk
  class ARI
    class Events < Resources
      # A hangup was requested on the channel.
      struct ChannelHangupRequest < Event

        # Integer representation of the cause of the hangup.
        property cause : Int32? = nil

        # Whether the hangup request was a soft hangup request.
        property soft : Bool? = nil

        # The channel on which the hangup was requested.
        property channel : Channels::Channel
      end
    end
  end
end
