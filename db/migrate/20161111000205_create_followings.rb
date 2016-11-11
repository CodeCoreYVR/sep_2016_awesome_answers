class Follower < ApplicationRecord; end

class CreateFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: true
      t.references :follower, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
