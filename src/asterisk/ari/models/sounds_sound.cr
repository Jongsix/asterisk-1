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
    class Sounds < Resources
      # A media file that may be played back.
      struct Sound
        include JSON::Serializable

        # Sound's identifier.
        property id : String

        # Text description of the sound, usually the words spoken.
        property text : String? = nil

        # The formats and languages in which this sound is available.
        property formats : Array(Sounds::FormatLangPair)
      end
    end
  end
end
