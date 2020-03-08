module LogCR

    class Entry

        def initialize(@fields : Fields, @config : Config)
        end

        def info(info : String)
            log(LogLevel::INFO, info)
        end

        def warn(info : String)
            log(LogLevel::WARN, info)
        end

        def error(info : String)
            log(LogLevel::ERROR, info)
        end

        def log(level : LogLevel, info : String)
            if level.value < @config.loglevel.value
                return
            end

            s = "[#{Time.local.to_s}] [#{level}] {#{@config.nil? ? "" : @config.not_nil!.prefix}} #{info}\n"
            @fields.each_key do |f|
                s += "\t#{f}=#{@fields[f]}\n"
            end

            puts s
            s
        end

        def append(fields : Fields)
            @fields.merge! fields
        end

    end

end