module Asterisk
  module Generator
    class ARI
      class Resource
        getter api_data : JSON::Any
        @description : String? = ""

        def filename(resource_name)
          base_url = "%{root_dir}/src/asterisk/ari/resources/%{resource_name}.cr"
          base_url % {
            root_dir:      Asterisk::Generator.current_dir,
            resource_name: resource_name.underscore,
          }
        end

        def initialize(@api_data : JSON::Any)
          resource = api_data["resourcePath"].to_s.split("/").last.split(".").first.camelcase
          model = <<-END
                  #------------------------------------------------------------------------------
                  #
                  #  WARNING !
                  #
                  #  This is a generated file. DO NOT EDIT THIS FILE! Your changes will
                  #  be lost the next time this file is regenerated.
                  #
                  #  This file was generated using ctiapps/asterisk crystal shard from the
                  #  Asterisk PBX version #{`asterisk -rx "core show version"`.split[1]}.
                  #
                  #------------------------------------------------------------------------------

                  module Asterisk
                    class ARI
                      class #{resource} < Resources
                  #{operations}
                      end
                    end
                  end
                  END

          model = model.gsub(/ +$/m, "").gsub("\n\n\n", "\n\n").strip.chomp
          file = File.open(filename(resource), "w")
          file.puts model
          file.close
        end

        def operation(endpoint, operation)
          summary = operation["summary"]? || @description

          http_operation = operation["httpMethod"].to_s.downcase

          # convert ARI JSON path to the HTTP URL:
          # "/channels/{channelId}/snoop/{snoopId}" =>
          # "channels/{channel_id}/snoop/{snoop_id}"
          url = Array(String).new
          endpoint.split("/").each do |slice|
            if slice =~ /\{(.+)\}/
              slice = "\#{" + $1.underscore + "}"
            end
            url.push(slice)
          end
          url = url.join("/").gsub(/^\//, "")

          response = Datatype.new(operation["responseClass"].to_s).set!

          if operation["parameters"]?
            parameters = Parameters.new operation["parameters"]
            if parameters.body_type.size > 1
              raise "body_type > 1"
            end
            arguments = parameters.arguments
            arguments_spec = parameters.arguments_spec
          else
            parameters = nil
            arguments = ""
            arguments_spec = nil
          end

          error_responses = operation["errorResponses"]?.try &.as_a.map { |error|
            {error.as_h["code"].to_s => error.as_h["reason"].to_s}
          }.reduce({} of String => String) { |memo, item| memo.merge(item) }
          error_responses = {} of String => String if error_responses.nil?

          errors = if error_responses.empty?
                     nil
                   else
                     errors_ = error_responses.map { |code, reason|
                       "- #{code} - #{reason}"
                     }.join("\n")
                     errors_ = "\n" + "\nError responses:\n#{errors_}".gsub(/^/m, "      # ")
                   end

          name = operation["nickname"].to_s.underscore

          name = %(#{name}#{arguments.empty? ? "" : "(#{arguments})"}#{response == "Nil" ? "" : " : HTTP::Client::Response | #{response}"})
          <<-END
                # #{summary}#{arguments_spec}#{errors}
                def #{name}
                  #{ # HTTP::Params.encode({"author" => "John Doe", "offset" => "20"})

  if (parameters.try &.query_type.size || 0) >= 1
      # to avoid casting
      query_params = (parameters.try &.query_type).as(Array(Parameter))

      # split query_params by required value
      required_params = Array(Parameter).new
      optional_params = Array(Parameter).new
      query_params.each do |parameter|
        if parameter.required?
          required_params.push parameter
        else
          optional_params.push parameter
        end
      end

      # lines of code for resulting method
      code = Array(String).new

      # # comments, remove for production-ready generator
      # code.push query_params.pretty_inspect.gsub(/^/m, "# "); code.push "#"

      # # encode query parameters like:
      # code.push "params = HTTP::Params.encode({\"author\" => \"John Doe\", \"offset\" => \"20\"})"
      params_already_defined = false

      if required_params.size >= 1
        params_already_defined = true

        r = required_params.dup
        # first
        parameter = r.shift
        params = %(params = HTTP::Params.encode({"#{parameter.name_ari}" => #{parameter.name}#{".to_s" unless parameter.datatype =~ /String/}}))
        code.push params

        # remainig
        r.map do |parameter|
          code.push %(params += "&" + HTTP::Params.encode({"#{parameter.name_ari}" => #{parameter.name}#{".to_s" unless parameter.datatype =~ /String/}}))
        end
      end

      if optional_params.size >= 1
        # empty space
        code.push "" if required_params.size >= 1

        code.push "# Optional parameters"
        code.push "params = HTTP::Params.encode({} of String => String)" unless params_already_defined
        optional_params.map do |parameter|
          code.push %(params += "&" + HTTP::Params.encode({"#{parameter.name_ari}" => #{parameter.name}#{".to_s" unless parameter.datatype =~ /String/}}) if #{parameter.name})
        end
        # empty space
        code.push ""
      end

      body_params = parameters.try &.body_type.as(Array(Parameter)) || Array(Parameter).new
      if response == "Nil"
        code.push %(ari.#{http_operation} "#{url}?" + params#{if body = body_params.first?
                                                                ", body: #{body.name}.to_json"
                                                              end})
      else
        code.push %(request = "#{url}?" + params)
        code.push %(format_response ari.#{http_operation}(request#{if body = body_params.first?
                                                                     ", body: #{body.name}.to_json"
                                                                   end}), #{response})
      end

      code.join("\n").strip.gsub(/\n^/m, "\n        ")
    else
      body_params = parameters.try &.body_type.as(Array(Parameter)) || Array(Parameter).new
      if response == "Nil"
        %(ari.#{http_operation} "#{url}"#{if body = body_params.first?
                                            ",\n  body: #{body.name}.to_json"
                                          end})
      else
        # lines of code for resulting method
        code = Array(String).new
        code.push %(format_response ari.#{http_operation}("#{url}"#{if body = body_params.first?
                                                                      ", body: #{body.name}.to_json"
                                                                    end}), #{response})
        code.join("\n").strip.gsub(/\n^/m, "\n        ")
      end
    end
}
                end
          END
        end

        def operations
          api_data["apis"].as_a.map { |operations|
            @description = operations["description"]?.try &.to_s
            operations["operations"].as_a.map { |operation|
              endpoint = operations["path"].to_s
              operation(endpoint, operation)
            }.join("\n\n")
          }.join("\n\n")
        end
      end
    end
  end
end
