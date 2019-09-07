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
      # A channel initiated a media hold.
      struct ChannelHold < Event

        # The channel that initiated the hold event.
        property channel : Channels::Channel

        # The music on hold class that the initiator requested.
        property musicclass : String? = nil
      end
    end
  end
end
