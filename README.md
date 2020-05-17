### `bin.cr`

A simple `pastebin` clone written in Crystal.

#### Installation

```sh
git clone https://github.com/7wf/bin.cr && cd bin.cr
shards
crystal run src/bin.cr
```

#### Usage

A web server will listen at port 8080.

###### Homepage

You can `GET /` and `GET /help.txt` to view the help text.

The help text can be changed by modifying the paste `help.txt` directly.

###### Example

```sh
$ curl http://127.0.0.1:8080
See https://github.com/7wf/bin.cr
```

> If you'd like to modify the help text, you can edit `pastes/help.txt`.

##### Creating a paste

To create pastes, you can use `POST /pastes` with body contents.

The server should reply with the ID of the generated paste.

###### Example

```sh
$ echo "Hello, world." | http -b POST http://127.0.0.1:8080/pastes
n5fl

$ cat file.txt | http -b POST http://127.0.0.1:8080/pastes
o2fK
```

##### Viewing a paste

To view a paste, you need to have the paste ID.

With the paste ID you can `GET /{paste id}` and the server will reply with paste contents.

###### Example

```sh
$ http GET http://127.0.0.1:8080/n5fl
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 14

Hello, world.
```

#### Contributing

1. Fork it (<https://github.com/7wf/bin.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

#### Contributors

- [7wf](https://github.com/7wf) - creator and maintainer