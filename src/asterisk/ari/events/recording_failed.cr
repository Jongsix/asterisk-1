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
      # Event showing failure of a recording operation.
      struct RecordingFailed < Event

        # Recording control object
        property recording : Recordings::LiveRecording
      end
    end
  end
end
