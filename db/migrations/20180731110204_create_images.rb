Hanami::Model.migration do
  change do
    create_table :images do
      primary_key :id
      foreign_key :article_id, :articles, on_delete: :cascade, null: false

      column :uri, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
