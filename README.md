# note-api-by-crystal

note-api-by-crystal is a sample web api project implemented by [Crystal](https://crystal-lang.org/).


## Requirements

1. Install Crystal  
https://crystal-lang.org/docs/installation/

2. Run database  
You can refer [here](https://github.com/shiba-hiro/note-mysql).


## Quick start

Can start by simply installing libs and executing it.
```
$ git clone https://github.com/shiba-hiro/note-api-by-crystal
$ cd note-api-by-crystal
$ shards install
$ crystal run src/note-api.cr
```

You can check state by health-check endpoint.  
This example use [httpie](https://httpie.org/), of course curl is also OK.
```
$ http GET http://localhost:3000/health-check
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 128
Content-Type: application/json
X-Powered-By: Kemal

{
    "app": {
        "message": "Application is running.",
        "success": true
    },
    "db_connection": {
        "message": "Database is available.",
        "success": true
    }
}
```


## Usage

note-api supports simple CRUD operations.

```
$ http POST http://localhost:3000/v1/notes title="My First Note" content="I started to take note."
HTTP/1.1 201 Created
Connection: keep-alive
Content-Length: 195
Content-Type: application/json
X-Powered-By: Kemal

{
    "content": "I started to take note.", 
    "created_at": "2018-06-13T14:58:38.231+00:00", 
    "id": "bf8f34a5-4374-4a18-9704-8c3aa29d336d", 
    "title": "My First Note", 
    "updated_at": "2018-06-13T14:58:38.231+00:00"
}
```

```
$ http GET http://localhost:3000/v1/notes/bf8f34a5-4374-4a18-9704-8c3aa29d336d
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 195
Content-Type: application/json
X-Powered-By: Kemal

{
    "content": "I started to take note.", 
    "created_at": "2018-06-13T14:58:38.231+00:00", 
    "id": "bf8f34a5-4374-4a18-9704-8c3aa29d336d", 
    "title": "My First Note", 
    "updated_at": "2018-06-13T14:58:38.231+00:00"
}
```

```
$ http PUT http://localhost:3000/v1/notes/bf8f34a5-4374-4a18-9704-8c3aa29d336d title="My First Note" content="I started to take note. But it's difficult to continue everyday..."
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 238
Content-Type: application/json
X-Powered-By: Kemal

{
    "content": "I started to take note. But it's difficult to continue everyday...", 
    "created_at": "2018-06-13T14:58:38.231+00:00", 
    "id": "bf8f34a5-4374-4a18-9704-8c3aa29d336d", 
    "title": "My First Note", 
    "updated_at": "2018-06-13T15:03:40.739+00:00"
}
```

```
$ http DELETE http://localhost:3000/v1/notes/bf8f34a5-4374-4a18-9704-8c3aa29d336d
HTTP/1.1 204 No Content
Connection: keep-alive
Content-Length: 0
Content-Type: application/json
X-Powered-By: Kemal
```


## Test

A. Execute spec programs  
```
$ KEMAL_ENV=test crystal spec
```

B. Execute newman script  
You can refer [here](https://github.com/shiba-hiro/note-newman-test).

## Run as a Docker container

Insert environment variables on run phase.
```
$ crystal build src/note-api.cr --release
$ sudo docker build . -t note-api
$ sudo docker run -dt -p 80:80 -e PORT=80 -e MYSQL_HOST=0.0.0.0 -e KEMAL_ENV=production --name note-api note-api
```


## Libraries
Kemal, which is a simple web framework.  
[Kemal](https://github.com/kemalcr/kemal)

Crecto as a database wrapper.  
[Crecto](https://github.com/Crecto/crecto)