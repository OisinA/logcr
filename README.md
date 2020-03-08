# logcr

A simple structured logging library for Crystal. I hope to add JSON support in the future.

## Usage

```crystal
LogCR.initialise LogCR::Config.new("test", LogCR::LogLevel::INFO)
LogCR.with_fields(LogCR::Field{"test"=>"success"}).info("test")
```

## Contributing

1. Fork it (<https://github.com/OisinA/logcr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [OisinA](https://github.com/OisinA) - creator and maintainer
