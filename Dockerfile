# Use the official lightweight Python 3.14 image as the base image
FROM python:3.14-slim

# Set /app as the working directory inside the Docker container
WORKDIR /app

# Copy requirements.txt from the project into the container
COPY requirements.txt .

# Install all Python dependencies listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask application into the container
COPY app.py .

# Tell Docker that the application uses port 5000
EXPOSE 5000

# Start the Flask application when the container starts
CMD ["python", "app.py"]
