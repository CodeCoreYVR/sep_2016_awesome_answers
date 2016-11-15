class AddOauthFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_secret, :string
    add_column :users, :oauth_raw_data, :text

    # this creates a composite index for the users table on the combination of
    # the uid and provider fields
    add_index :users, [:uid, :provider]
  end
end
