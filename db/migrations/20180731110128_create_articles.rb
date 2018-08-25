Hanami::Model.migration do
  change do
    create_table :articles do
      primary_key :id

      column :title, String, null: false
      column :content, "text[]"
      column :content_summary, "text[]"
      column :types, String
      column :authors, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
