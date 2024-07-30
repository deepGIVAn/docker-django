# FROM python:3.12.4-slim-bookworm
# WORKDIR /app
# COPY ./ajax-crud .
# RUN pip install --upgrade pip --no-cache-dir
# RUN pip install -r /app/requirements.txt --no-cache-dir

# CMD gunicorn ajaxcrud.wsgi-application --bind 0.0.0.0:8000

# Use the official Python image from the Docker Hub
FROM python:3.12.4-slim-bookworm

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ./ajax-crud /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
# EXPOSE 8000
# CMD gunicorn ajaxcrud.wsgi:application --bind 0.0.0.0:8000

# Run gunicorn server
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "ajaxcrud.wsgi:application"]

# Use the official Python image from the Docker Hub
# FROM python:3.12.4-slim-bookworm

# Set the working directory in the container
# WORKDIR /app

# Copy the current directory contents into the container at /app
# COPY . /app

# Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/static

# Collect static files
# RUN python manage.py collectstatic --noinput

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run gunicorn server
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "ajaxcrud.wsgi:application"]
