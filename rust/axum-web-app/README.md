# README

## How to create a Axum web project

```bash
cargo new {project-name}
cd {project-name}
cargo add tokio --features=macros,rt-multi-thread
cargo add clap --features=derive
cargo add axum

# edit ./src/main.rs

cargo run -- --port 4000
cargo check
cargo test
cargo build --release
./target/release/{project-name}
```
## Build Docker

### How to build Docker image

```
docker build . --tag mingyuchoo/rust/axum-web-app:latest
```

### How to run Docker Container

```
docker run -p 4000:4000 mingyuchoo/rust/axum-web-app:latest
# or
docker run -d -p 4000:4000 mingyuchoo/rust/axum-web-app:latest
```
