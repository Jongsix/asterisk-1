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
    class Endpoints < Resource
      # A key/value pair variable in a text message.
      struct TextMessageVariable
        include JSON::Serializable

        # A unique key identifying the variable.
        property key : String

        # The value of the variable.
        property value : String
      end
    end
  end
end
