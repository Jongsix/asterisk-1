#------------------------------------------------------------------------------
#
#  WARNING !
#
#  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
#  be lost the next time this file is regenerated.
#
#  This file was generated using ctiapps/asterisk crystal shard from the
#  Asterisk PBX version 16.6.0.
#
#------------------------------------------------------------------------------

module Asterisk
  class ARI
    class Bridges < Resources
      # List all active bridges in Asterisk.
      def list : HTTP::Client::Response | Array(Bridges::Bridge)
        format_response ari.get("bridges"), Array(Bridges::Bridge)
      end

      # Create a new bridge.
      #
      # Arguments:
      # - `type` - comma separated list of bridge type attributes (mixing, holding, dtmf_events, proxy_media, video_sfu);
      # - `bridge_id` - unique ID to give to the bridge being created;
      # - `name` - name to give to the bridge being created;
      def create(type : String? = nil, bridge_id : String? = nil, name : String? = nil) : HTTP::Client::Response | Bridges::Bridge
        # Optional parameters
        params = HTTP::Params.encode({} of String => String)
        params += "&" + HTTP::Params.encode({"type" => type}) if type
        params += "&" + HTTP::Params.encode({"bridgeId" => bridge_id}) if bridge_id
        params += "&" + HTTP::Params.encode({"name" => name}) if name

        request = "bridges?" + params
        format_response ari.post(request), Bridges::Bridge
      end

      # Create a new bridge or updates an existing one.
      #
      # Arguments:
      # - `bridge_id` - unique ID to give to the bridge being created. (required);
      # - `type` - comma separated list of bridge type attributes (mixing, holding, dtmf_events, proxy_media, video_sfu) to set;
      # - `name` - set the name of the bridge;
      def create_with_id(bridge_id : String, type : String? = nil, name : String? = nil) : HTTP::Client::Response | Bridges::Bridge
        # Optional parameters
        params = HTTP::Params.encode({} of String => String)
        params += "&" + HTTP::Params.encode({"type" => type}) if type
        params += "&" + HTTP::Params.encode({"name" => name}) if name

        request = "bridges/#{bridge_id}?" + params
        format_response ari.post(request), Bridges::Bridge
      end

      # Get bridge details.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      #
      # Error responses:
      # - 404 - Bridge not found
      def get(bridge_id : String) : HTTP::Client::Response | Bridges::Bridge
        format_response ari.get("bridges/#{bridge_id}"), Bridges::Bridge
      end

      # Shut down a bridge.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      #
      # Error responses:
      # - 404 - Bridge not found
      def destroy(bridge_id : String)
        ari.delete "bridges/#{bridge_id}"
      end

      # Add a channel to a bridge.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `channel` - ids of channels to add to bridge. (required). Allow multiple instances (comma-separated list);
      # - `role` - channel's role in the bridge;
      # - `absorb_dtmf` - absorb DTMF coming from this channel, preventing it to pass through to the bridge;
      # - `mute` - mute audio from this channel, preventing it to pass through to the bridge;
      #
      # Error responses:
      # - 400 - Channel not found
      # - 404 - Bridge not found
      # - 409 - Bridge not in Stasis application; Channel currently recording
      # - 422 - Channel not in Stasis application
      def add_channel(bridge_id : String, channel : String, role : String? = nil, absorb_dtmf : Bool? = false, mute : Bool? = false)
        params = HTTP::Params.encode({"channel" => channel})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"role" => role}) if role
        params += "&" + HTTP::Params.encode({"absorbDTMF" => absorb_dtmf.to_s}) if absorb_dtmf
        params += "&" + HTTP::Params.encode({"mute" => mute.to_s}) if mute

        ari.post "bridges/#{bridge_id}/addChannel?" + params
      end

      # Remove a channel from a bridge.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `channel` - ids of channels to remove from bridge. (required). Allow multiple instances (comma-separated list);
      #
      # Error responses:
      # - 400 - Channel not found
      # - 404 - Bridge not found
      # - 409 - Bridge not in Stasis application
      # - 422 - Channel not in this bridge
      def remove_channel(bridge_id : String, channel : String)
        params = HTTP::Params.encode({"channel" => channel})
        ari.post "bridges/#{bridge_id}/removeChannel?" + params
      end

      # Set a channel as the video source in a multi-party mixing bridge. This operation has no effect on bridges with two or fewer participants.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `channel_id` - channel's id. (required);
      #
      # Error responses:
      # - 404 - Bridge or Channel not found
      # - 409 - Channel not in Stasis application
      # - 422 - Channel not in this Bridge
      def set_video_source(bridge_id : String, channel_id : String)
        ari.post "bridges/#{bridge_id}/videoSource/#{channel_id}"
      end

      # Removes any explicit video source in a multi-party mixing bridge. This operation has no effect on bridges with two or fewer participants. When no explicit video source is set, talk detection will be used to determine the active video stream.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      #
      # Error responses:
      # - 404 - Bridge not found
      def clear_video_source(bridge_id : String)
        ari.delete "bridges/#{bridge_id}/videoSource"
      end

      # Play music on hold to a bridge or change the MOH class that is playing.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `moh_class` - channel's id;
      #
      # Error responses:
      # - 404 - Bridge not found
      # - 409 - Bridge not in Stasis application
      def start_moh(bridge_id : String, moh_class : String? = nil)
        # Optional parameters
        params = HTTP::Params.encode({} of String => String)
        params += "&" + HTTP::Params.encode({"mohClass" => moh_class}) if moh_class

        ari.post "bridges/#{bridge_id}/moh?" + params
      end

      # Stop playing music on hold to a bridge.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      #
      # Error responses:
      # - 404 - Bridge not found
      # - 409 - Bridge not in Stasis application
      def stop_moh(bridge_id : String)
        ari.delete "bridges/#{bridge_id}/moh"
      end

      # Start playback of media on a bridge.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `media` - media URIs to play. (required). Allow multiple instances (comma-separated list);
      # - `lang` - for sounds, selects language for sound;
      # - `offsetms` - number of milliseconds to skip before playing. Only applies to the first URI if multiple media URIs are specified;
      # - `skipms` - number of milliseconds to skip for forward/reverse operations;
      # - `playback_id` - playback Id;
      #
      # Error responses:
      # - 404 - Bridge not found
      # - 409 - Bridge not in a Stasis application
      def play(bridge_id : String, media : String, lang : String? = nil, offsetms : Int32? = 0, skipms : Int32? = 3000, playback_id : String? = nil) : HTTP::Client::Response | Playbacks::Playback
        params = HTTP::Params.encode({"media" => media})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"lang" => lang}) if lang
        params += "&" + HTTP::Params.encode({"offsetms" => offsetms.to_s}) if offsetms
        params += "&" + HTTP::Params.encode({"skipms" => skipms.to_s}) if skipms
        params += "&" + HTTP::Params.encode({"playbackId" => playback_id}) if playback_id

        request = "bridges/#{bridge_id}/play?" + params
        format_response ari.post(request), Playbacks::Playback
      end

      # Start playback of media on a bridge.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `playback_id` - playback ID. (required);
      # - `media` - media URIs to play. (required). Allow multiple instances (comma-separated list);
      # - `lang` - for sounds, selects language for sound;
      # - `offsetms` - number of milliseconds to skip before playing. Only applies to the first URI if multiple media URIs are specified;
      # - `skipms` - number of milliseconds to skip for forward/reverse operations;
      #
      # Error responses:
      # - 404 - Bridge not found
      # - 409 - Bridge not in a Stasis application
      def play_with_id(bridge_id : String, playback_id : String, media : String, lang : String? = nil, offsetms : Int32? = 0, skipms : Int32? = 3000) : HTTP::Client::Response | Playbacks::Playback
        params = HTTP::Params.encode({"media" => media})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"lang" => lang}) if lang
        params += "&" + HTTP::Params.encode({"offsetms" => offsetms.to_s}) if offsetms
        params += "&" + HTTP::Params.encode({"skipms" => skipms.to_s}) if skipms

        request = "bridges/#{bridge_id}/play/#{playback_id}?" + params
        format_response ari.post(request), Playbacks::Playback
      end

      # Start a recording.
      #
      # Arguments:
      # - `bridge_id` - bridge's id. (required);
      # - `name` - recording's filename. (required);
      # - `format` - format to encode audio in. (required);
      # - `max_duration_seconds` - maximum duration of the recording, in seconds. 0 for no limit;
      # - `max_silence_seconds` - maximum duration of silence, in seconds. 0 for no limit;
      # - `if_exists` - action to take if a recording with the same name already exists;
      # - `beep` - play beep when recording begins;
      # - `terminate_on` - dTMF input to terminate recording;
      #
      # Error responses:
      # - 400 - Invalid parameters
      # - 404 - Bridge not found
      # - 409 - Bridge is not in a Stasis application; A recording with the same name already exists on the system and can not be overwritten because it is in progress or ifExists=fail
      # - 422 - The format specified is unknown on this system
      def record(bridge_id : String, name : String, format : String, max_duration_seconds : Int32? = 0, max_silence_seconds : Int32? = 0, if_exists : String? = "fail", beep : Bool? = false, terminate_on : String? = "none") : HTTP::Client::Response | Recordings::LiveRecording
        params = HTTP::Params.encode({"name" => name})
        params += "&" + HTTP::Params.encode({"format" => format})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"maxDurationSeconds" => max_duration_seconds.to_s}) if max_duration_seconds
        params += "&" + HTTP::Params.encode({"maxSilenceSeconds" => max_silence_seconds.to_s}) if max_silence_seconds
        params += "&" + HTTP::Params.encode({"ifExists" => if_exists}) if if_exists
        params += "&" + HTTP::Params.encode({"beep" => beep.to_s}) if beep
        params += "&" + HTTP::Params.encode({"terminateOn" => terminate_on}) if terminate_on

        request = "bridges/#{bridge_id}/record?" + params
        format_response ari.post(request), Recordings::LiveRecording
      end
    end
  end
end
