Hanami::Model.migration do
  change do
    create_table :articles do
      primary_key :id
      
      column :title, String, null: false
      column :description, "text[]"
      column :category, String
      column :significance, "text[]"

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
