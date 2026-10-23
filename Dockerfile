# Dockerfile for Nuclei scanning with cosckoya templates
# Multi-stage build for minimal image size

FROM golang:1.27.3-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache git make gcc musl-dev

# Install Nuclei CLI
RUN go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Runtime stage
FROM alpine:3.20

WORKDIR /nuclei

# Install ca-certificates for SSL/TLS
RUN apk add --no-cache ca-certificates tzdata && \
    update-ca-certificates

# Copy Nuclei binary from builder
COPY --from=builder /go/bin/nuclei /usr/local/bin/nuclei

# Create non-root user
RUN addgroup -g 1001 nuclei && \
    adduser -D -u 1001 -G nuclei nuclei && \
    mkdir -p /home/nuclei/.config/nuclei && \
    chown -R nuclei:nuclei /home/nuclei /nuclei

USER nuclei

# Default templates directory
ENV NUCLEI_TEMPLATES_DIR=/nuclei/templates
ENV XDG_CONFIG_HOME=/home/nuclei/.config

# Copy project templates
COPY --chown=nuclei:nuclei templates/ /nuclei/templates/
COPY --chown=nuclei:nuclei workflows/ /nuclei/workflows/
COPY --chown=nuclei:nuclei nuclei-config.yaml /home/nuclei/.config/nuclei/config.yaml

# Default command
ENTRYPOINT ["nuclei"]
CMD ["-h"]
