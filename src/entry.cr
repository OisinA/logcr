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
            puts "[#{Time.local.to_s}] [#{level}] {#{@config.nil? ? "" : @config.not_nil!.prefix}} " + info
            @fields.each_key do |f|
                puts "\t#{f}=#{@fields[f]}"
            end
        end

        def append(fields : Fields)
            @fields.merge! fields
        end

    end

end