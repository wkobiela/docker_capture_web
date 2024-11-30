FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
ADD requirements.txt /tmp/
ADD screenshot.py /tmp/

RUN mkdir -p /tmp/screenshot

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    dpkg \
    software-properties-common \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcairo2 \
    libcups2 \
    libcurl3-gnutls \
    libcurl3-nss \
    libcurl4 \
    libdbus-1-3 \
    libdrm2 \
    libexpat1 \
    libgbm1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libgtk-4-1 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libvulkan1 \
    libx11-6 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    python3-pip \
    xdg-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# automatically accept licence of MS fonts
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections

# install additional Bootstrap fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
    fontconfig \
    ttf-mscorefonts-installer \
    fonts-liberation \
    fonts-liberation \
    fonts-noto \
    fonts-roboto \
    fonts-dejavu \
    fonts-ubuntu && \
    fc-cache -f -v && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /tmp/screenshot

ENTRYPOINT ["python3", "/tmp/screenshot.py"]
CMD ["--help"]
