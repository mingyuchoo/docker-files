# Set base image
FROM python:3.13.1-alpine3.21

# Set working directory
WORKDIR /app

# Install required packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy files to destination
COPY . .

# Expose the application port
EXPOSE 4000

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "4000"]
