FROM python:3.8.7-slim

# Set number of gunicorn workers .
ENV NUMBER_OF_GUNICORN_WORKERS=2
# Prevent Python io buffering.
ENV PYTHONUNBUFFERED=1
# Stop Python from creating *.pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Create non root user and django group
RUN groupadd -r django && useradd -r -s /bin/false -g django django

# Copy insights-ui source.
WORKDIR /app
COPY . ./

# Give django user read access to project source.
RUN chown -R django:django /app

# Install dependencies
RUN pip install --upgrade pip
RUN pip install gunicorn
RUN pip install -r requirements.txt

#USER django

# Kick-off Gunicorn
CMD exec gunicorn --bind :$PORT --workers $NUMBER_OF_GUNICORN_WORKERS insights.wsgi:application
