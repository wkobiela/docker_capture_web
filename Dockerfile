FROM python:3.11-slim

ENV PYTHONUNBUFFERED=True

WORKDIR /tmp
ADD requirements.txt /tmp/
ADD screenshot.py /tmp/

RUN mkdir -p /tmp/screenshot

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    dpkg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /tmp/screenshot

ENTRYPOINT ["python", "/tmp/screenshot.py"]
CMD ["--help"]
