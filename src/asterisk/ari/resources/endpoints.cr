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
    class Endpoints < Resources
      # List all endpoints.
      def list : HTTP::Client::Response | Int32
        response = client.get "endpoints"
        response.status_code.to_s =~ /^[23]\d\d$/ ? Int32.from_json(response.body_io.gets) : response
      end

      # Send a message to some technology URI or endpoint.
      #
      # Arguments:
      # - `to` - the endpoint resource or technology specific URI to send the message to. Valid resources are sip, pjsip, and xmpp.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: to,
      #
      # - `from` - the endpoint resource or technology specific identity to send this message from. Valid resources are sip, pjsip, and xmpp.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: from,
      #
      # - `body` - the body of the message.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: body,
      #
      # - `variables` - the "variables" key in the body object holds technology specific key/value pairs to append to the message. These can be interpreted and used by the various resource types; for example, pjsip and sip resource types will add the key/value pairs as SIP headers,.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: body,
      #   - param name: variables,
      #
      # API endpoint:
      # - method: put
      # - endpoint: /endpoints/sendMessage
      #
      # Error responses:
      # - 400 - Invalid parameters for sending a message.
      # - 404 - Endpoint not found
      def send_message(to : String, from : String, body : String? = nil, variables : Hash(String, String | Bool | Int32 | Float32)? = nil)
        params = HTTP::Params.encode({"to" => to, "from" => from})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"body" => body}) if body

        client.put "endpoints/sendMessage?" + params, body: variables.to_json
      end

      # List available endoints for a given endpoint technology.
      #
      # Arguments:
      # - `tech` - technology of the endpoints (sip,iax2,...).
      #   - Required: true,
      #   - Allow multiple (comma-separated list): ,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: tech,
      #
      # API endpoint:
      # - method: get
      # - endpoint: /endpoints/{tech}
      #
      # Error responses:
      # - 404 - Endpoints not found
      def list_by_tech(tech : String) : HTTP::Client::Response | Int32
        response = client.get "endpoints/#{tech}"
        response.status_code.to_s =~ /^[23]\d\d$/ ? Int32.from_json(response.body_io.gets) : response
      end

      # Details for an endpoint.
      #
      # Arguments:
      # - `tech` - technology of the endpoint.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): ,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: tech,
      #
      # - `resource` - iD of the endpoint.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): ,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: resource,
      #
      # API endpoint:
      # - method: get
      # - endpoint: /endpoints/{tech}/{resource}
      #
      # Error responses:
      # - 400 - Invalid parameters for sending a message.
      # - 404 - Endpoints not found
      def get(tech : String, resource : String) : HTTP::Client::Response | Int32
        response = client.get "endpoints/#{tech}/#{resource}"
        response.status_code.to_s =~ /^[23]\d\d$/ ? Int32.from_json(response.body_io.gets) : response
      end

      # Send a message to some endpoint in a technology.
      #
      # Arguments:
      # - `tech` - technology of the endpoint.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): ,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: tech,
      #
      # - `resource` - iD of the endpoint.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): ,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: resource,
      #
      # - `from` - the endpoint resource or technology specific identity to send this message from. Valid resources are sip, pjsip, and xmpp.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: from,
      #
      # - `body` - the body of the message.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: body,
      #
      # - `variables` - the "variables" key in the body object holds technology specific key/value pairs to append to the message. These can be interpreted and used by the various resource types; for example, pjsip and sip resource types will add the key/value pairs as SIP headers,.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: body,
      #   - param name: variables,
      #
      # API endpoint:
      # - method: put
      # - endpoint: /endpoints/{tech}/{resource}/sendMessage
      #
      # Error responses:
      # - 400 - Invalid parameters for sending a message.
      # - 404 - Endpoint not found
      def send_message_to_endpoint(tech : String, resource : String, from : String, body : String? = nil, variables : Hash(String, String | Bool | Int32 | Float32)? = nil)
        params = HTTP::Params.encode({"from" => from})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"body" => body}) if body

        client.put "endpoints/#{tech}/#{resource}/sendMessage?" + params, body: variables.to_json
      end
    end
  end
end
