require "json"

module LogCR
  VERSION = "0.1.1"
end

# Logger class manages the configuration of the Logger
class LogCR::Logger
  getter prefix, level, format, output

  def initialize(@prefix : String, @level : LogCR::LogLevel, @format : LogCR::Format, @output : IO = STDOUT)
  end

  # Create a new Log entry with the provided fields
  def with_fields(fields : Hash(String, String)) : LogCR::Entry
    return LogCR::Entry.new("", fields, self)
  end

  # Create a new debug log message
  def debug(message : String, line = __LINE__, file = __FILE__) : String
    fields = {} of String => String
    entry = LogCR::Entry.new(message, fields, self)
    return @format.output(self, entry, :debug, line, file)
  end

  # Create a new info log message
  def info(message : String, line = __LINE__, file = __FILE__) : String
    fields = {} of String => String
    entry = LogCR::Entry.new(message, fields, self)
    return @format.output(self, entry, :info, line, file)
  end

  # Create a new warn log message
  def warn(message : String, line = __LINE__, file = __FILE__) : String
    fields = {} of String => String
    entry = LogCR::Entry.new(message, fields, self)
    return @format.output(self, entry, :warn, line, file)
  end

  # Create a new error log message
  def error(message : String, line = __LINE__, file = __FILE__) : String
    fields = {} of String => String
    entry = LogCR::Entry.new(message, fields, self)
    return @format.output(self, entry, :error, line, file)
  end
end

# LogLevel defines which logs to show and which to not, controlled by the Logger class
enum LogCR::LogLevel
  Debug
  Info
  Warn
  Error
end

# The format to output the logs as, Simple is readable and nicely formatted, JSON is for parsing by a log collector
enum LogCR::Format
  Simple
  Json

  def output(logger : LogCR::Logger, entry : LogCR::Entry, level : LogCR::LogLevel, line : Int32, file : String) : String
    if level.value < logger.level.value
      return ""
    end
    case self
    when Simple
      result = "#{Time.local.to_s} [#{logger.prefix}] [#{level.to_s.upcase}] #{entry.message}\n#{entry.fields.keys.map { |s| "\t#{s} => #{entry.fields[s]}" }.join("\n")}"
      logger.output.puts result
      return result
    when Json
      result = {
        "msg"    => entry.message,
        "_level" => level.to_s.downcase,
        "_line"  => line.to_s,
        "_file"  => file,
      }.merge(entry.fields).to_json
      logger.output.puts result
      return result
    end

    return ""
  end
end

# Stores the data about a particular log entry and can be used to create a log message
struct LogCR::Entry
  getter fields, message

  @fields : Hash(String, String)

  def initialize(@message : String, @logger : LogCR::Logger)
    @fields = {} of String => String
  end

  def initialize(@message : String, @fields : Hash(String, String), @logger : LogCR::Logger)
  end

  # Create a new log entry with these added fields
  def with_fields(fields : Hash(String, String)) : LogCR::Entry
    return LogCR::Entry.new(@message, @fields.merge(fields), @logger)
  end

  # Create a new debug log message
  def debug(message : String, line = __LINE__, file = __FILE__) : String
    entry = LogCR::Entry.new(message, @fields, @logger)
    return @logger.format.output(@logger, entry, :debug, line, file)
  end

  # Create a new info log message
  def info(message : String, line = __LINE__, file = __FILE__) : String
    entry = LogCR::Entry.new(message, @fields, @logger)
    return @logger.format.output(@logger, entry, :info, line, file)
  end

  # Create a new warn log message
  def warn(message : String, line = __LINE__, file = __FILE__) : String
    entry = LogCR::Entry.new(message, @fields, @logger)
    return @logger.format.output(@logger, entry, :warn, line, file)
  end

  # Create a new error log message
  def error(message : String, line = __LINE__, file = __FILE__) : String
    entry = LogCR::Entry.new(message, @fields, @logger)
    return @logger.format.output(@logger, entry, :error, line, file)
  end
end
