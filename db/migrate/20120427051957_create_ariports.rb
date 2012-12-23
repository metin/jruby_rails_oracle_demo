class CreateAriports < ActiveRecord::Migration
  def change
    create_table :ariports do |t|

      t.timestamps
    end
  end
end
