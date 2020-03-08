module LogCR

    class Config

        getter prefix
        getter loglevel

        def initialize(@prefix : String, @loglevel : LogLevel)
            
        end

    end

end