require "./spec_helper"

# TODO: add not only sanity check but also fail case
# TODO: add mote complex data
describe "Note API" do
  it "can get list of notes" do
    get "/v1/notes"

    response.status_code.should eq 200
  end

  it "can create a note" do
    request_body = {
      title:   "note title",
      content: "note content",
    }.to_json
    post "/v1/notes", body: request_body

    response.status_code.should eq 201
    created = Repo.get(Model::Note, JSON.parse(response.body)["id"].to_s)
    created.should be_truthy
    created.as(Model::Note).title.should eq "note title"
    created.as(Model::Note).content.should eq "note content"
  end

  it "can get a note" do
    note = Model::Note.new
    note.id = UUID.random.to_s
    note.title = "title"
    note.content = "content"
    changeset = Repo.insert(note)

    get "/v1/notes/#{note.id}"

    response.status_code.should eq 200
    JSON.parse(response.body)["id"].should eq note.id
  end

  it "can update a note" do
    note = Model::Note.new
    note.id = UUID.random.to_s
    note.title = "old title"
    note.content = "old content"
    changeset = Repo.insert(note)

    request_body = {
      title:   "new title",
      content: "new content",
    }.to_json
    put "/v1/notes/#{note.id}", body: request_body

    response.status_code.should eq 200
    updated = Repo.get(Model::Note, note.id)
    updated.as(Model::Note).title.should eq "new title"
    updated.as(Model::Note).content.should eq "new content"
  end

  it "can delete a note" do
    note = Model::Note.new
    note.id = UUID.random.to_s
    note.title = "title"
    note.content = "content"
    changeset = Repo.insert(note)

    delete "/v1/notes/#{note.id}"

    response.status_code.should eq 204
    Repo.get(Model::Note, note.id).should be_nil
  end
end
