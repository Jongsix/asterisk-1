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
    class Asterisk < Resources
      # Info about Asterisk status
      struct StatusInfo
        include JSON::Serializable

        # Time when Asterisk was started.
        property startup_time : Time

        # Time when Asterisk was last reloaded.
        property last_reload_time : Time
      end
    end
  end
end
