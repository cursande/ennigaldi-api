Hanami::Model.migration do
  change do
    create_table :articles do
      primary_key :id

      # TODO: at some point, may want to actually change these text
      # types back to arrays: could be a more useful way to transport
      # data client-side
      column :title, String, null: false
      column :content, "text"
      column :content_summary, "text"
      column :types, String
      column :authors, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
