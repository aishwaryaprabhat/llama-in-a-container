# Use Ubuntu as the base image
FROM ubuntu:latest

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y g++ python3 python3-pip git htop

# Create a non-root user
RUN useradd -ms /bin/bash llamauser

# Set the working directory
WORKDIR /home/llamademo

# Define environment variables with default values
ENV HUGGINGFACEHUB_API_TOKEN=
ENV HF_REPO=TheBloke/Llama-2-13B-chat-GGML
ENV HF_MODEL_FILE=llama-2-13b-chat.ggmlv3.q5_1.bin
ENV JUPYTER_PORT=8888
ENV DOWNLOAD_LATER=false

# Copy the necessary files into the container
COPY download_model.py .
COPY entrypoint.sh .
COPY requirements.txt .
COPY Example.ipynb .

# Set execute permissions on the entrypoint script
RUN chmod +x entrypoint.sh

# Install required Python packages
RUN pip install -r requirements.txt

# Expose the Jupyter Lab port
EXPOSE ${JUPYTER_PORT}

USER llamauser

# Run the entrypoint script only if HUGGINGFACEHUB_API_TOKEN is available
CMD if [ -n "$HUGGINGFACEHUB_API_TOKEN" ]; then ./entrypoint.sh; else echo "HUGGINGFACEHUB_API_TOKEN is required"; exit 1; fi

