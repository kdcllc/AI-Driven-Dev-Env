# `uv` python version and deps manager

[Installing `uv`](https://docs.astral.sh/uv/getting-started/installation/)

Installing `uv` is simple. You can install it using the following command:

```bash
    curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Using UV with Docker

For containerized Python projects, UV can significantly speed up dependency installation. Below is a Dockerfile template that uses a multi-stage build approach to leverage UV's performance while keeping the image size small:

```dockerfile
# Stage 1: Builder stage for installing dependencies
FROM python:3.11-slim AS builder

# Set environment variables to optimize UV
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV VIRTUAL_ENV=/opt/venv

# Install build essentials and UV
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl build-essential && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN uv venv $VIRTUAL_ENV

# Update PATH to use the virtual environment
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy dependency files first to leverage Docker caching
COPY pyproject.toml uv.lock* ./

# Install dependencies using UV
RUN uv sync --locked --all-extras

# Stage 2: Runtime stage with minimal dependencies
FROM python:3.11-slim AS runtime

# Set environment variable for the virtual environment
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder $VIRTUAL_ENV $VIRTUAL_ENV

# Copy the application code
COPY . .

# Verify the installation
RUN python -c "import sys; print(f'Python version: {sys.version}')" && \
    python -m pip list

# Expose port if your application needs it
# EXPOSE 8000

# Set the entrypoint and default command
# Customize these based on your application
CMD ["python", "app.py"]
```

### Key Features

1. **Multi-stage build**: Separates build environment from runtime environment
2. **UV optimization**: Uses bytecode compilation and efficient dependency linking
3. **Caching strategy**: Copies dependency files first for better layer caching
4. **Minimal runtime image**: Includes only the virtual environment and application code

More details: [Microsoft's blog on Dockerizing UV](https://devblogs.microsoft.com/ise/dockerizing-uv/)
