require "./spec_helper"

describe LogCR do
  it "works" do
    logger = LogCR::Logger.new("test", :info, :simple)
    entry = logger.with_fields({
      "test"  => "success",
      "alert" => "epic",
      "oh"    => "no",
    })

    result = entry.with_fields({"another" => "one"}).info("test")
    result.should_not eq ""
  end

  it "levels" do
    logger = LogCR::Logger.new("test", :debug, :simple)
    result = logger.debug("hello")
    result.should_not eq ""
    result = logger.info("hello")
    result.should_not eq ""
    result = logger.warn("hello")
    result.should_not eq ""
    result = logger.error("hello")
    result.should_not eq ""

    logger = LogCR::Logger.new("test", :info, :simple)
    result = logger.debug("hello")
    result.should eq ""
    result = logger.info("hello")
    result.should_not eq ""
    result = logger.warn("hello")
    result.should_not eq ""
    result = logger.error("hello")
    result.should_not eq ""

    logger = LogCR::Logger.new("test", :warn, :simple)
    result = logger.debug("hello")
    result.should eq ""
    result = logger.info("hello")
    result.should eq ""
    result = logger.warn("hello")
    result.should_not eq ""
    result = logger.error("hello")
    result.should_not eq ""

    logger = LogCR::Logger.new("test", :error, :simple)
    result = logger.debug("hello")
    result.should eq ""
    result = logger.info("hello")
    result.should eq ""
    result = logger.warn("hello")
    result.should eq ""
    result = logger.error("hello")
    result.should_not eq ""
  end

  it "other io" do
    string = String::Builder.new
    logger = LogCR::Logger.new("test", :debug, :simple, string)
    logger.debug("hello")

    string.to_s[27..].should eq "[test] [DEBUG] hello\n"
  end
end
