class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    # sometimes this kind of code is called DSL: Domain Specific Language.
    # it's still Ruby code but written in a way that seems like a new language
    # Ruby is flexible to allow that.

    # This migration file is not the database or the database table. It's
    # a list of instructions to generate the SQL to create the table in the
    # database
    create_table :questions do |t|
      # by default Rails will always create a primary key integer: id
      t.string :title
      t.text :body

      # this generate two timestamp columns: created_at & updated_at
      t.timestamps
    end
  end
end
