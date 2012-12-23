class Work < ActiveRecord::Base
  set_table_name "Works"
  attr_accessible :eid, :did, :pct_time
end
