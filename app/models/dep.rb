class Dep < ActiveRecord::Base
  set_table_name "Dep"
  attr_accessible :content, :name, :title
end
