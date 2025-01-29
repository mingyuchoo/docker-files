# README

## How to create a Axum web project

```bash
cargo new {project-name}
cd {project-name}
cargo add tokio --features=macros,rt-multi-thread
cargo add clap --features=derive
cargo add axum

# edit ./src/main.rs

cargo run -- --port 8080
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
docker run -p 8080:8080 mingyuchoo/rust/axum-web-app:latest
# or
docker run -p 8080:8080 -it mingyuchoo/rust/axum-web-app:latest /bin/bash
```