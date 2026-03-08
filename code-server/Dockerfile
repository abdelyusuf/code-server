FROM node:20-slim AS builder

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -fL https://github.com/coder/code-server/releases/download/v4.89.1/code-server-4.89.1-linux-amd64.tar.gz \
    -o code-server.tar.gz && \
    mkdir code-server && \
    tar -xzf code-server.tar.gz -C code-server --strip-components=1

FROM node:20-slim

RUN useradd -m coder

RUN apt-get update && \
    apt-get install -y bash procps && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/coder/.local/share/code-server/User/globalStorage

COPY --from=builder /app/code-server /home/coder/code-server

RUN chown -R coder:coder /home/coder

USER coder
WORKDIR /home/coder/code-server

EXPOSE 8080

CMD ["./bin/code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]