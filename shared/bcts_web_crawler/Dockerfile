FROM python:3.11.9-slim-bookworm

# Force HOME away from /
ENV HOME=/tmp/home
RUN mkdir -p $HOME && chmod -R 777 $HOME


# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    curl \
    wget \
    unzip \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libxss1 \
    libxrandr2 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    fonts-liberation \
    libappindicator1 \
    xdg-utils \
    ca-certificates \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Chrome system dependencies first
RUN apt-get update && apt-get install -y \
    libgbm1 \
    libgtk-3-0 \
    libxkbcommon0 \
    libvulkan1 \
    && rm -rf /var/lib/apt/lists/*

# Then install Chrome
RUN wget -q -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get update && apt-get install -y /tmp/google-chrome.deb && \
    rm /tmp/google-chrome.deb


# Install Chromedriver matching Chrome version
RUN CHROME_VERSION=$(google-chrome --version | grep -oP '\d+\.\d+\.\d+') && \
    echo "Detected Chrome version: $CHROME_VERSION" && \
    DRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE") && \
    echo "Using Chromedriver version: $DRIVER_VERSION" && \
    wget -q -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm /tmp/chromedriver.zip

# Create UC data path and set env
ENV UCD_DATA_PATH=/tmp/ucdata
RUN mkdir -p /tmp/ucdata && chmod -R 777 /tmp/ucdata


# Install Python dependencies
RUN pip install --no-cache-dir \
    pandas \
    psycopg \
    selenium \
    undetected-chromedriver==3.4.7

# Setup working directory
WORKDIR /app

# Copy project files
COPY . .
