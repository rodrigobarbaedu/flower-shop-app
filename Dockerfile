# Use a Python base image
FROM python:3.10

# Set the working directory to /app
WORKDIR /app

# Install virtualenv
RUN pip install virtualenv

# Create and activate the virtual environment
RUN virtualenv environment
RUN /bin/bash -c "source environment/bin/activate"

# Copy the requirements file to install dependencies
COPY requirements.txt .

# Install dependencies within the virtual environment
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Run the application
CMD ["python", "source/app_rest.py"]
