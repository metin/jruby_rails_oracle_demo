class Dept < ActiveRecord::Base
  attr_accessible :did, :budget, :managerid
  set_primary_key "DID"
  set_table_name "Dept"

end
