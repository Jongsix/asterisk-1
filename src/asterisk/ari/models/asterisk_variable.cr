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
    class Asterisk < Resources
      # The value of a channel variable
      struct Variable
        include JSON::Serializable

        # The value of the variable requested
        property value : String
      end
    end
  end
end
