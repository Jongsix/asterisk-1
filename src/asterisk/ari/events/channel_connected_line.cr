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
      # Channel changed Connected Line.
      struct ChannelConnectedLine < Event

        # The channel whose connected line has changed.
        property channel : Channels::Channel
      end
    end
  end
end
