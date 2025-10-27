# Build stage 
FROM alpine:3.22.2 as builder

# Set arguments for configuration
ARG SOCKS_VERSION=v1.23.5

# Install dependencies
RUN apk add --no-cache tar xz wget ca-certificates && update-ca-certificates

RUN echo "Downloading shadowsocks-rust version: ${SOCKS_VERSION}"

# Download and install SOCKS
RUN wget https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SOCKS_VERSION}/shadowsocks-${SOCKS_VERSION}.x86_64-unknown-linux-musl.tar.xz && \
    tar -xvf shadowsocks-${SOCKS_VERSION}.x86_64-unknown-linux-musl.tar.xz

# Runtime stage
FROM alpine:3.22.2

RUN apk add --no-cache ca-certificates && update-ca-certificates

ARG SOCKS_VERSION=v1.23.5
# Set environment variables for configuration
ENV SOCKS_MODE=server
ENV SOCKS_VERSION=${SOCKS_VERSION}

# Copy Shadowsocks binaries from builder
COPY --from=builder /ssserver /usr/local/bin/ssserver
COPY --from=builder /ssmanager /usr/local/bin/ssmanager
COPY --from=builder /sslocal /usr/local/bin/sslocal

# Config directory (mountable as volume)
VOLUME /config
WORKDIR /config
    
# Entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]