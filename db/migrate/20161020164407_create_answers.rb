class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      # this will generate an integer field called `question_id`
      # foreign_key: true =>
      t.references :question, foreign_key: true, index: true

      t.timestamps
    end
  end
end
