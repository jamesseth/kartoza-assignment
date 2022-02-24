FROM python:3.8.7-slim
ENV PROJECT_NAME kartoza

# Set number of gunicorn workers .
ENV NUMBER_OF_GUNICORN_WORKERS=2
# Prevent Python io buffering.
ENV PYTHONUNBUFFERED=1
# Stop Python from creating *.pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Create non root user and django group
RUN groupadd -r django && useradd -r -s /bin/false -g django django

WORKDIR /app
COPY . ./

# Give django user read access to project source.
RUN chown -R django:django /app

# Install dependencies
RUN pip install --upgrade pip==20.3.4
RUN pip install gunicorn
RUN pip install -r requirements.txt


#USER django

# Kick-off Gunicorn
CMD exec gunicorn --bind :8000 --workers $NUMBER_OF_GUNICORN_WORKERS ${PROJECT_NAME}.wsgi:application
