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
    class Recordings < Resources
      # A past recording that may be played back.
      struct StoredRecording
        include JSON::Serializable

        property name : String

        property format : String
      end
    end
  end
end