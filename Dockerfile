# Build netflix movie catalog file
# Install python
ARG PY_VER=3.8.12-slim-buster
#FROM python:3.8.12-slim-buster
FROM python:$PY_VER
# Copy source code
WORKDIR /app
COPY requirements.txt .
# venv? isolated already so not required - install dependencies
RUN pip install -r requirements.txt
COPY . .
# Run the applcation
CMD ["python3", "app.py"]