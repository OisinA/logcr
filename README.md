# LogCR

![Release](https://img.shields.io/github/v/release/oisina/logcr) [![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](<https://oisina.github.io/logcr/>)

A simple structured logging library for Crystal. Supports either readable output or JSON.

## Usage

```crystal
logger = LogCR::Logger.new("test", :info, :simple)
logger.with_fields({"key"=>"value"}).info("out")
```

```
2020-08-10 22:33:19 +01:00 [test] [INFO] out
        key => value
```

### Different Log Levels

```crystal
LogCR::Logger.new("test", :debug, :simple)
LogCR::Logger.new("test", :info, :simple)
LogCR::Logger.new("test", :warn, :simple)
LogCR::Logger.new("test", :error, :simple)
```

### JSON Output
```crystal
logger = LogCR::Logger.new("test", :info, :json)
logger.with_fields({"key"=>"value"}).info("out")
```

```
{"msg":"out","_level":"info","_line":"7","_file":"/home/Projects/logcr/spec/logcr_spec.cr","key":"value"}
```

## Contributing

1. Fork it (<https://github.com/OisinA/logcr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [OisinA](https://github.com/OisinA) - creator and maintainer
