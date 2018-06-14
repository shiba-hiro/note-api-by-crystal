module Interface
  class NoteUpsertRequest
    JSON.mapping({
      title:   String,
      content: String,
    })

    def self.from_request(context : HTTP::Server::Context)
      from_json(context.request.body.as(IO))
    rescue e
      raise Exceptions::InvalidRequestFormat.new body_name: name, cause: e
    end
  end

  class NoteResponse
    JSON.mapping({
      id:         String?,
      title:      String?,
      content:    String?,
      created_at: {type: Time?, converter: ZonedDateTimeConverter},
      updated_at: {type: Time?, converter: ZonedDateTimeConverter},
    })

    def initialize(note : Model::Note)
      @id = note.id
      @title = note.title
      @content = note.content
      @created_at = note.created_at
      @updated_at = note.updated_at
    end
  end
end
