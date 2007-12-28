require File.dirname(__FILE__) + '/../test_helper'

class SubjectTest < Test::Unit::TestCase
  fixtures :subjects, :clients

  def test_crud
     preallowed = clients(:preallowed)
     aNewSubject = Subject.new(
                           :name => "New Test Subject",
                           :client => preallowed
                         )
     assert aNewSubject.save

     preallowedSuperSubject = subjects(:super_user)
     assert_equal "admin", preallowedSuperSubject.name

     aNewSubject.name = "updated name"
     assert aNewSubject.save
     aNewSubject.reload

     assert_equal "updated name", aNewSubject.name

     assert aNewSubject.destroy
   end
end
