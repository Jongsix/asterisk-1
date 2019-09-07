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
    class Asterisk < Resource
      # Retrieve a dynamic configuration object.
      #
      # Arguments:
      # - `config_class` - the configuration class containing dynamic configuration objects.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: configClass,
      #
      # - `object_type` - the type of configuration object to retrieve.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: objectType,
      #
      # - `id` - the unique identifier of the object to retrieve.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: id,
      #   - endpoint (get): /asterisk/config/dynamic/{configClass}/{objectType}/{id}
      #
      # Error responses:
      # - 404 - {configClass|objectType|id} not found
      def get_object(config_class : String, object_type : String, id : String) : Array(Asterisk::ConfigTuple)
        response = client.get "/asterisk/config/dynamic/#{config_class}/#{object_type}/#{id}"
      end

      # Create or update a dynamic configuration object.
      #
      # Arguments:
      # - `config_class` - the configuration class containing dynamic configuration objects.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: configClass,
      #
      # - `object_type` - the type of configuration object to create or update.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: objectType,
      #
      # - `id` - the unique identifier of the object to create or update.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: id,
      #
      # - `fields` - the body object should have a value that is a list of ConfigTuples, which provide the fields to update. Ex. [ { "attribute": "directmedia", "value": "false" } ].
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: body,
      #   - param name: fields,
      #   - endpoint (put): /asterisk/config/dynamic/{configClass}/{objectType}/{id}
      #
      # Error responses:
      # - 400 - Bad request body
      # - 403 - Could not create or update object
      # - 404 - {configClass|objectType} not found
      def update_object(config_class : String, object_type : String, id : String, fields : Hash(String, String | Bool | Int32 | Float32)? = nil) : Array(Asterisk::ConfigTuple)
        response = client.put "/asterisk/config/dynamic/#{config_class}/#{object_type}/#{id}",
  body: fields.to_json
      end

      # Delete a dynamic configuration object.
      #
      # Arguments:
      # - `config_class` - the configuration class containing dynamic configuration objects.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: configClass,
      #
      # - `object_type` - the type of configuration object to delete.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: objectType,
      #
      # - `id` - the unique identifier of the object to delete.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: id,
      #   - endpoint (delete): /asterisk/config/dynamic/{configClass}/{objectType}/{id}
      #
      # Error responses:
      # - 403 - Could not delete object
      # - 404 - {configClass|objectType|id} not found
      def delete_object(config_class : String, object_type : String, id : String)
        response = client.delete "/asterisk/config/dynamic/#{config_class}/#{object_type}/#{id}"
      end

      # Gets Asterisk system information.
      #
      # Arguments:
      # - `only` - filter information returned.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): true,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: only,
      #   - endpoint (get): /asterisk/info
      def get_info(only : String? = nil) : Asterisk::AsteriskInfo
        # Optional parameters
        params = HTTP::Params.encode({} of String => String)
        params += "&" + HTTP::Params.encode({"only" => only}) if only

        client.get "/asterisk/info?" + params
      end

      # Response pong message.
      def ping : Asterisk::AsteriskPing
        client.get "/asterisk/ping"
      end

      # List Asterisk modules.
      def list_modules : Array(Asterisk::Module)
        client.get "/asterisk/modules"
      end

      # Get Asterisk module information.
      #
      # Arguments:
      # - `module_name` - module's name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: moduleName,
      #   - endpoint (get): /asterisk/modules/{moduleName}
      #
      # Error responses:
      # - 404 - Module could not be found in running modules.
      # - 409 - Module information could not be retrieved.
      def get_module(module_name : String) : Asterisk::Module
        response = client.get "/asterisk/modules/#{module_name}"
      end

      # Load an Asterisk module.
      #
      # Arguments:
      # - `module_name` - module's name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: moduleName,
      #   - endpoint (post): /asterisk/modules/{moduleName}
      #
      # Error responses:
      # - 409 - Module could not be loaded.
      def load_module(module_name : String)
        response = client.post "/asterisk/modules/#{module_name}"
      end

      # Unload an Asterisk module.
      #
      # Arguments:
      # - `module_name` - module's name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: moduleName,
      #   - endpoint (delete): /asterisk/modules/{moduleName}
      #
      # Error responses:
      # - 404 - Module not found in running modules.
      # - 409 - Module could not be unloaded.
      def unload_module(module_name : String)
        response = client.delete "/asterisk/modules/#{module_name}"
      end

      # Reload an Asterisk module.
      #
      # Arguments:
      # - `module_name` - module's name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: moduleName,
      #   - endpoint (put): /asterisk/modules/{moduleName}
      #
      # Error responses:
      # - 404 - Module not found in running modules.
      # - 409 - Module could not be reloaded.
      def reload_module(module_name : String)
        response = client.put "/asterisk/modules/#{module_name}"
      end

      # Gets Asterisk log channel information.
      def list_log_channels : Array(Asterisk::LogChannel)
        client.get "/asterisk/logging"
      end

      # Adds a log channel.
      #
      # Arguments:
      # - `log_channel_name` - the log channel to add.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: logChannelName,
      #
      # - `configuration` - levels of the log channel.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: configuration,
      #   - endpoint (post): /asterisk/logging/{logChannelName}
      #
      # Error responses:
      # - 400 - Bad request body
      # - 409 - Log channel could not be created.
      def add_log(log_channel_name : String, configuration : String)
        params = HTTP::Params.encode({"configuration" => configuration})
        response = client.post "/asterisk/logging/#{log_channel_name}?" + params
      end

      # Deletes a log channel.
      #
      # Arguments:
      # - `log_channel_name` - log channels name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: logChannelName,
      #   - endpoint (delete): /asterisk/logging/{logChannelName}
      #
      # Error responses:
      # - 404 - Log channel does not exist.
      def delete_log(log_channel_name : String)
        response = client.delete "/asterisk/logging/#{log_channel_name}"
      end

      # Rotates a log channel.
      #
      # Arguments:
      # - `log_channel_name` - log channel's name.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: path,
      #   - param name: logChannelName,
      #   - endpoint (put): /asterisk/logging/{logChannelName}/rotate
      #
      # Error responses:
      # - 404 - Log channel does not exist.
      def rotate_log(log_channel_name : String)
        response = client.put "/asterisk/logging/#{log_channel_name}/rotate"
      end

      # Get the value of a global variable.
      #
      # Arguments:
      # - `variable` - the variable to get.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: variable,
      #   - endpoint (get): /asterisk/variable
      #
      # Error responses:
      # - 400 - Missing variable parameter.
      def get_global_var(variable : String) : Asterisk::Variable
        params = HTTP::Params.encode({"variable" => variable})
        response = client.get "/asterisk/variable?" + params
      end

      # Set the value of a global variable.
      #
      # Arguments:
      # - `variable` - the variable to set.
      #   - Required: true,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: variable,
      #
      # - `value` - the value to set the variable to.
      #   - Required: false,
      #   - Allow multiple (comma-separated list): false,
      #   ARI (http-client) related:
      #   - http request type: query,
      #   - param name: value,
      #   - endpoint (post): /asterisk/variable
      #
      # Error responses:
      # - 400 - Missing variable parameter.
      def set_global_var(variable : String, value : String? = nil)
        params = HTTP::Params.encode({"variable" => variable})

        # Optional parameters
        params += "&" + HTTP::Params.encode({"value" => value}) if value

        response = client.post "/asterisk/variable?" + params
      end
    end
  end
end
