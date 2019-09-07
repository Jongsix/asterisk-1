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
    class Mailboxes < Resource
      # List all mailboxes.
      def self.list : Array(Mailboxes::Mailbox)
        client.get "/mailboxes"
      end

      # Retrieve the current state of a mailbox.
      #
      # Arguments:
      # - `mailbox_name` - name of the mailbox.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: mailboxName,
      #   - endpoint (get): /mailboxes/{mailboxName}
      #
      # Error responses:
      # - 404 - Mailbox not found
      def self.get(mailbox_name : String) : Mailboxes::Mailbox
        response = client.get "/mailboxes/#{mailbox_name}"
      end

      # Change the state of a mailbox. (Note - implicitly creates the mailbox).
      #
      # Arguments:
      # - `mailbox_name` - name of the mailbox.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: mailboxName,
      #
      # - `old_messages` - count of old messages in the mailbox.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: oldMessages,
      #
      # - `new_messages` - count of new messages in the mailbox.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: newMessages,
      #   - endpoint (put): /mailboxes/{mailboxName}
      #
      # Error responses:
      # - 404 - Mailbox not found
      def self.update(mailbox_name : String, old_messages : Int32, new_messages : Int32)
        params = HTTP::Params.encode({"oldMessages" => old_messages, "newMessages" => new_messages})
        response = client.put "/mailboxes/#{mailbox_name}?" + params
      end

      # Destroy a mailbox.
      #
      # Arguments:
      # - `mailbox_name` - name of the mailbox.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: mailboxName,
      #   - endpoint (delete): /mailboxes/{mailboxName}
      #
      # Error responses:
      # - 404 - Mailbox not found
      def self.delete(mailbox_name : String)
        response = client.delete "/mailboxes/#{mailbox_name}"
      end
    end
  end
end
