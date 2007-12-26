require File.dirname(__FILE__) + '/../test_helper'

class LogRecordTest < Test::Unit::TestCase
  fixtures :log_records, :subjects, :resources

 
  def test_crud
    logRecord = log_records(:access_granted)
    logAccessGranted = LogRecord.new(
      :req_body => "request.body.string",
      :req_headers => "request.headers",
      :req_method =>  "request.method",
      :req_path => "asd",
      :resp_headers => "response.headers",
      :resp_status => "200 Ok"
    )
                              
    assert logAccessGranted.save
    
    logAccessDenied = LogRecord.new(
      :req_body => "request.body.string",
      :req_headers => "request.headers",
      :req_method =>  "request.method",
      :req_path => "asd",
      :resp_headers => "response.headers",
      :resp_status => "303 denied"
    )
        
    assert logAccessDenied.save
    
    
    assert logAccessDenied.save
    assert logAccessDenied.reload
    
    assert logAccessDenied.destroy
    assert logAccessGranted.destroy
  end
end
