#------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using ctiapps/asterisk crystal shard from the
#  Asterisk PBX version 16.5.1.
#
#------------------------------------------------------------------------------

module Asterisk
  class ARI
    class Events < Resources
      # WebSocket connection for events.
      #
      # Arguments:
      # - `app` - applications to subscribe to.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): true,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: app,
      #
      # - `subscribe_all` - subscribe to all Asterisk events. If provided, the applications listed will be subscribed to all events, effectively disabling the application specific subscriptions. Default is 'false'.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: subscribeAll,
      #
      # API endpoint:
      # - method: get
      # - endpoint: /events
      def event_websocket(app : String, subscribe_all : Bool? = nil) : HTTP::Client::Response | Message
        params = HTTP::Params.encode({"app" => app})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"subscribeAll" => subscribe_all.to_s}) if subscribe_all

        response = client.get "events?" + params
        response.status_code.to_s =~ /^[23]\d\d$/ ? Message.from_json(response.body_io.gets) : response
      end

      # Generate a user event.
      #
      # Arguments:
      # - `event_name` - event name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: eventName,
      #
      # - `application` - the name of the application that will receive this event.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: application,
      #
      # - `source` - uRI for event source (channel:{channelId}, bridge:{bridgeId}, endpoint:{tech}/{resource}, deviceState:{deviceName}.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): true,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: source,
      #
      # - `variables` - the "variables" key in the body object holds custom key/value pairs to add to the user event. Ex. { "variables": { "key": "value" } }.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: body,
      #   - param name: variables,
      #
      # API endpoint:
      # - method: post
      # - endpoint: /events/user/{eventName}
      #
      # Error responses:
      # - 404 - Application does not exist.
      # - 422 - Event source not found.
      # - 400 - Invalid even tsource URI or userevent data.
      def user_event(event_name : String, application : String, source : String? = nil, variables : Hash(String, String | Bool | Int32 | Float32)? = nil)
        params = HTTP::Params.encode({"application" => application})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"source" => source}) if source

        client.post "events/user/#{event_name}?" + params, body: variables.to_json
      end
    end
  end
end
