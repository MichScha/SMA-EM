FROM python:3.11-slim

LABEL maintainer="SMA-EM Docker"
LABEL description="SMA Energy Meter Daemon"

WORKDIR /opt/smaemd

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY daemon3x.py .
COPY speedwiredecoder.py .
COPY sma-daemon.py .
COPY features/ ./features/
COPY libs/ ./libs/

# Create necessary directories
RUN mkdir -p /etc/smaemd /run/shm

# Default config location
VOLUME ["/etc/smaemd"]

# Run the daemon in foreground mode (for Docker)
CMD ["python3", "sma-daemon.py", "run"]
