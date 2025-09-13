
## titanic_ml_test_1

This repository is a small experiment that demonstrates a machine learning model trained on the Titanic dataset and wrapped with a FastAPI service. The project is packaged in a Docker container and includes a simple web UI (`app.html`) for making predictions.

### What you'll find in this repo

- `app_api.py` — FastAPI application that exposes prediction and health endpoints.
- `app.html` — A small UI to interact with the API from a browser.
- `titanic.csv` — Raw dataset used for training/testing.
- `train.ipynb` — Notebook used to explore and train the model.
- `requirements.txt` / `pyproject.toml` — Python dependencies.
- `Dockerfile` — Optional containerization for the FastAPI app.

### Quick contract

- Input: JSON payload with passenger features (e.g. `Pclass`, `Age`, `Fare`, ...).
- Output: JSON with predicted survival (0/1) and optional probability.
- Error modes: invalid/missing fields return 4xx; server errors return 5xx.

### Endpoints (examples)

- `GET /health` — basic health check.
- `GET /stats` — service statistics (e.g. number of predictions made).
- `POST /predict_model` — returns a prediction for a single passenger. The exact body fields depend on the model and preprocessing used in `app_api.py`.

Note: The endpoints above match the implementation used during development; if you changed route names, update the calls accordingly.

### Run locally (recommended quick start)

1. Create and activate a virtual environment (macOS / zsh):

```bash
python3 -m venv .venv
source .venv/bin/activate
```

2. Install dependencies:

```bash
pip install -r requirements.txt
```

3. Start the FastAPI app (two common options):

```bash
python app_api.py
```

1. Open the UI: either open `app.html` directly in a browser, or navigate to `http://127.0.0.1:5000/` (if the app serves the file). The UI posts requests to the prediction endpoint.

### Run with Docker

Build the image and run the container (from the repo root):

```bash
docker build -t titanic-ml-test:latest .
docker run -p 5000:5000 titanic-ml-test:latest
```

After the container is running, use the UI or curl to interact with the API.

### Example curl requests

Health check:

```bash
curl -X GET http://127.0.0.1:5000/health
```

Get stats:

```bash
curl -X GET http://127.0.0.1:5000/stats
```

Predict (example payload — adjust fields to match your model):

```bash
curl -X POST http://127.0.0.1:5000/predict_model \
	-H "Content-Type: application/json" \
	-d '{"Pclass": 3, "Age": 22.0, "Fare": 7.25}'
```

### Notes and next steps

- `train.ipynb` contains the training steps and can be used to retrain or improve the model.
- If you change the model inputs or preprocessing, update `app_api.py` and the UI to match.
- Consider adding a minimal test (e.g. pytest) to validate the prediction endpoint.

If you'd like, I can also:

- Add a small Docker Compose file for local dev.
- Add a unit test that exercises the `/predict_model` endpoint.
- Improve `app.html` with clearer input validation.

---

If you want the README in Russian or a shorter variant, tell me which sections to trim.
