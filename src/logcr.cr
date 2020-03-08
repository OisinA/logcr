require "./config"
require "./entry"

module LogCR
    VERSION = "0.10.0"

    enum LogLevel
        WARN
        INFO
        DEBUG
        ERROR
    end

    alias Fields = Hash(String, String | Int32 | Bool | Int8 | Int16)

    @@config = Config.new "", LogLevel::INFO

    def self.initialise(@@config : Config)
    end

    def self.with_fields(fields : Fields)
        Entry.new fields, @@config
    end

    def self.with_error(error : Exception)
        Entry.new(Fields{"error" => error.message.not_nil!}, @@config)
    end

    def self.info(info : String)
        Entry.new(Fields.new, @@config).info(info)
    end

    def self.warn(info : String)
        Entry.new(Fields.new, @@config).warn(info)
    end

    def self.error(info : String)
        Entry.new(Fields.new, @@config).error(info)
    end

end