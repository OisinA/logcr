require "./spec_helper"

describe LogCR do
    
    it "works" do 
        LogCR.initialise LogCR::Config.new("test", LogCR::LogLevel::INFO)
        result = LogCR.with_fields(LogCR::Fields{"test"=>"success"}).info("test")

        result.not_nil![29..result.not_nil!.size].should eq "[INFO] {test} test\n\ttest=success\n"
    end

end