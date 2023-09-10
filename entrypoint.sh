#!/bin/sh

# Check if DOWNLOAD_LATER is set to false
if [ "$DOWNLOAD_LATER" = "false" ]; then
  # Run the Python script and capture its output as the environment variable
  export MODEL_LOCAL_PATH=$(python3 download_model.py)

  # Check if MODEL_LOCAL_PATH is empty
  if [ -z "$MODEL_LOCAL_PATH" ]; then
    echo "Python script execution failed or did not produce output. Exiting..."
    exit 1
  fi
else
  echo "Skipping model download as DOWNLOAD_LATER is set to true."
fi

# Start Jupyter Lab using the specified port (default: 8888)
echo "Starting Jupyter Lab on port $JUPYTER_PORT..."
jupyter lab --port=$JUPYTER_PORT --ip=0.0.0.0
