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

- You can use `GET /` to view the `help` file.
- Use `GET /pasteid` to see a paste.
- Use `POST /pastes` to create a new paste.

#### Contributing

1. Fork it (<https://github.com/7wf/bin.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

#### Contributors

- [7wf](https://github.com/7wf) - creator and maintainer