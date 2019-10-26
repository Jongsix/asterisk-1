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
      # Details of an Asterisk log channel
      struct LogChannel
        include JSON::Serializable

        # The log channel path
        property channel : String

        # Types of logs for the log channel
        property type : String

        # Whether or not a log type is enabled
        property status : String

        # The various log levels
        property configuration : String
      end
    end
  end
end
