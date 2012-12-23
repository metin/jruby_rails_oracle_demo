class Emp < ActiveRecord::Base
  set_table_name "Emp"
  set_primary_key "EID"
  attr_accessible :eid, :ename, :age, :salary

  before_create do
    self.eid ||=  'eid'
  end
  
end
