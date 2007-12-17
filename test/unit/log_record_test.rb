require File.dirname(__FILE__) + '/../test_helper'

class LogRecordTest < Test::Unit::TestCase
  fixtures :log_records, :subjects, :resources

 
  def test_crud
    logRecord = log_records(:access_granted)
    logAccessGranted = LogRecord.new(
                              :subject    => subjects(:super_user),
                              :resource => resources(:preallowed_super_user),
                              :granted    => true,
                              :notes      => "resources granted in this case" 
                              )
                              
    assert logAccessGranted.save
    
    logAccessDenied = LogRecord.new(
                              :subject    => subjects(:super_user),
                              :resource => resources(:preallowed_super_user),
                              :granted    => false,
                              :notes      => "resources denied in this case" 
                              )
    
    assert logAccessDenied.save
    
    logAccessDenied.granted = true
    
    assert logAccessDenied.save
    assert logAccessDenied.reload
    assert true, logAccessDenied.granted
    
    assert logAccessDenied.destroy
    assert logAccessGranted.destroy
  end
end
