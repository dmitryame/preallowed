class LogRecord < ActiveRecord::Base
  belongs_to  :subject
  belongs_to  :resource
end
