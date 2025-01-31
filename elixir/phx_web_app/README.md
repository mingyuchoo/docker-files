# PhxWebApp

## How to create a Phoenix project

```bash
$ mix phx.new {project-name}
$ cd {project-name}
$ mix ecto.create
$ mix phx.server
```

## How to start this Phoenix app

```bash
$ mix setup
$ mix phx.server
# or
$ mix iex -S mix phx.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Build Docker

### How to build Docker image

```bash
docker build . --tag mingyuchoo/elixir/phx-web-app:latest
```

### How to run Docker Container

```bash
docker run -e SECRET_KEY_BASE=$(mix phx.gen.secret) -p 4000:4000 mingyuchoo/elixir/phx-web-app:latest
# or
docker run -e SECRET_KEY_BASE=$(mix phx.gen.secret) \
           -e DATABASE_URL=ecto://postgres:postgres@postgresql-db/postgres \
           --network docker-link \
           -d -p 4000:4000 mingyuchoo/elixir/phx-web-app:latest
```

### How to test in web browser

```bash
http://localhost:4000
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
