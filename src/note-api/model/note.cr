module Model
  class Note < Crecto::Model
    schema "notes" do
      field :id, String, primary_key: true
      field :title, String
      field :content, String
    end

    validate_required [:id, :title]
  end
end
