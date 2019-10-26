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
      # Notification that a blind transfer has occurred.
      struct BridgeBlindTransfer < Event
        # The channel performing the blind transfer
        property channel : Channels::Channel

        # The channel that is replacing transferer when the transferee(s) can not be transferred directly
        property replace_channel : Channels::Channel? = nil

        # The channel that is being transferred
        property transferee : Channels::Channel? = nil

        # The extension transferred to
        property exten : String

        # The context transferred to
        property context : String

        # The result of the transfer attempt
        property result : String

        # Whether the transfer was externally initiated or not
        property is_external : Bool

        # The bridge being transferred
        property bridge : Bridges::Bridge? = nil
      end
    end
  end
end
