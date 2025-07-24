
FROM alpine:latest

# Set environment variables
ENV POCKETBASE_VERSION=0.22.8

# Install dependencies
RUN apk add --no-cache curl

# Download PocketBase binary
RUN curl -L -o /pb.zip https://github.com/pocketbase/pocketbase/releases/download/v$POCKETBASE_VERSION/pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip &&     unzip /pb.zip -d /pb &&     rm /pb.zip

# Create data and migrations directories
RUN mkdir -p /pb/pb_data /pb/pb_migrations

# Copy project files
COPY . /pb

# Set working directory
WORKDIR /pb

# Expose PocketBase default port
EXPOSE 8090

# Start PocketBase
CMD ["./pocketbase", "serve", "--http=0.0.0.0:8090"]
