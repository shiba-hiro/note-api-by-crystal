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


## Test

Execute command.
```
$ KEMAL_ENV=test crystal spec
```


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