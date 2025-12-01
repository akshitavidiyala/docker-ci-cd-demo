# 1. Base image
FROM python:3.11-slim

# 2. Set working directory
WORKDIR /app

# 3. Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy app code
COPY app.py .

# 5. Expose app port
EXPOSE 5000

# 6. Run the app
CMD ["python", "app.py"]

