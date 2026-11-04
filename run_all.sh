#!/bin/bash

echo "Downloading data..."
python src/data_loader.py

echo "Training model..."
python src/train_model.py

echo "Starting FastAPI..."
uvicorn api.main:app --host 0.0.0.0 --port 8000 &

echo "Starting Streamlit dashboard..."
streamlit run dashboard/app.py --server.port 8502 --server.address 0.0.0.0 &

echo "Starting MLflow UI..."
mlflow ui --port 5050 --host 0.0.0.0 &

echo "All services started. Press [CTRL+C] to stop."

wait