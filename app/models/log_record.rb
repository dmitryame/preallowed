class LogRecord < ActiveRecord::Base
  belongs_to  :scope
  belongs_to  :subject
  belongs_to  :resource
end
