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

module Asterisk
  class ARI
    class Events < Resources
      # Base type for errors and events
      abstract struct Message
        include JSON::Serializable

        # Indicates the type of this message.
        property type : String

        # The unique ID for the Asterisk instance that raised this event.
        property asterisk_id : String? = nil
      end
    end
  end
end
