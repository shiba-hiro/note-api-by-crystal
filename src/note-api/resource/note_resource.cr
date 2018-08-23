get "/v1/notes" do |env|
  begin
    Repo.all(Model::Note).map { |note| Interface::NoteResponse.new(note) }.to_json
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end
end

post "/v1/notes" do |env|
  begin
    post_note = Interface::NoteUpsertRequest.from_json(env.request.body.as(IO))
  rescue e
    halt env, status_code: 422, response: Hash{"message" => e.to_s}.to_json
  end

  note = Model::Note.new
  note.id = UUID.random.to_s
  note.title = post_note.title
  note.content = post_note.content
  begin
    changeset = Repo.insert(note)
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end

  if changeset.errors.empty?
    halt env, status_code: 201, response: Interface::NoteResponse.new(note).to_json
  else
    halt env, status_code: 400, response: changeset.errors.to_json
  end
end

get "/v1/notes/:id" do |env|
  begin
    note = Repo.get(Model::Note, env.params.url["id"])
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end

  if note.nil?
    halt env, status_code: 404, response: Hash{"message" => "Note doesn't exist."}.to_json
  else
    halt env, status_code: 200, response: Interface::NoteResponse.new(note).to_json
  end
end

put "/v1/notes/:id" do |env|
  begin
    put_note = Interface::NoteUpsertRequest.from_json(env.request.body.as(IO))
  rescue e
    halt env, status_code: 422, response: Hash{"message" => e.to_s}.to_json
  end
  id = env.params.url["id"]

  begin
    note = Repo.get(Model::Note, id)
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end
  halt env, status_code: 404, response: Hash{"message" => "Note doesn't exist."}.to_json if note.nil?

  note.title = put_note.title
  note.content = put_note.content
  begin
    changeset = Repo.update(note)
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end

  if changeset.errors.empty?
    halt env, status_code: 200, response: Interface::NoteResponse.new(note).to_json
  else
    halt env, status_code: 400, response: changeset.errors.to_json
  end
end

delete "/v1/notes/:id" do |env|
  begin
    note = Repo.get(Model::Note, env.params.url["id"])
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end
  halt env, status_code: 204 if note.nil?

  begin
    changeset = Repo.delete(note)
  rescue e
    LOGGER.error(e.inspect_with_backtrace)
    halt env, status_code: 500, response: Hash{"message" => "Internal server error."}.to_json
  end

  if changeset.errors.empty?
    halt env, status_code: 204
  else
    halt env, status_code: 400, response: changeset.errors.to_json
  end
end
