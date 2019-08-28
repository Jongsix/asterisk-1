module Asterisk
  module Generator
    class ARI
      class Events
        getter api_data : JSON::Any
        getter! models : JSON::Any?

        def filename(resource_name, model_name)
          # base_url = "%{root_dir}/src/asterisk/ari/events/%{resource_name}_%{model_name}.cr"
          base_url = "%{root_dir}/src/asterisk/ari/events/%{model_name}.cr"
          base_url % {
            root_dir:      Asterisk::Generator.current_dir,
            resource_name: resource_name.underscore,
            model_name:    model_name.underscore
          }
        end

        def initialize(@api_data : JSON::Any)
          resource = api_data["resourcePath"].to_s.split("/").last.split(".").first.camelcase
          # resource = api_data["apis"].as_a.first["path"].to_s.split("/").last.camelcase
          return unless resource == "Events"

          @models = @api_data.as_h["models"]?
          return unless models?

          models.as_h.each do |model_name, model_data|
            klass = model_name.camelcase
            klass_description = model_data["description"]?.try &.to_s.gsub(/^/m, "# ")
            klass_definition = "struct #{klass}"
            # prefix
            if klass =~ /^Message|Event$/
              klass_definition = "abstract #{klass_definition}"
            end
            # all the classes eccept Message and MissingParams inherit from Event
            unless klass =~ /^Message$|^Event$|^MissingParams$/
              klass_definition = "#{klass_definition} < Event"
            end
            # Event and MissingParams inherit from Message
            if klass =~ /^Event$|^MissingParams$/
              klass_definition = "#{klass_definition} < Message"
            end
            # include JSON stuff to the root class
            if klass == "Message"
              # klass_definition = "#{klass_definition}\n        include JSON::Serializable\n        include JSON::Serializable::Unmapped"
              klass_definition = "#{klass_definition}\n        include JSON::Serializable"
            end

            parameters = Parameters.new model_data["properties"]

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
                    #{if klass =~ /^Event$|^MissingParams$/
                        %(require "./message.cr"\n\n)
                      elsif klass != "Message"
                        %(require "./event.cr"\n\n)
                      else
                        ""
                      end
                    }
                    module Asterisk
                      class ARI
                        class #{resource} < Resource
                          #{klass_description ? "#{klass_description}" : ""}
                          #{klass_definition}
                            #{parameters.struct_properties.chomp.gsub(/ +$/, "").chomp}
                          end
                        end
                      end
                    end
                    END

            model = model.gsub(/ +$/m, "")
            file = File.open(filename(resource, klass), "w")
            file.puts model
            file.close
          end

        end
      end
    end
  end
end
