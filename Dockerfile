FROM python:3.10-slim

RUN apt-get update && apt-get install -y ffmpeg imagemagick git fonts-liberation && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/<policy domain="path" rights="none" pattern="@\*"/<!-- <policy domain="path" rights="none" pattern="@\*" -->/' /etc/ImageMagick-6/policy.xml 2>/dev/null || true

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 10000

CMD ["streamlit", "run", "webui/Main.py", "--server.port", "10000", "--server.address", "0.0.0.0"]
