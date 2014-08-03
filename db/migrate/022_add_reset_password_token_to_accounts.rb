migration 22, :add_reset_password_token_to_accounts do
  up do
    modify_table :accounts do
      add_column :reset_password_token, String
      add_column :reset_password_generated_at, DateTime
    end
  end

  down do
    modify_table :accounts do
      drop_column :reset_password_token
      drop_column :reset_password_generated_at
    end
  end
end
