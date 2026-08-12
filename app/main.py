from fastapi import FastAPI

app = FastAPI(
    title="EKS Python API",
    description="A containerized REST API deployed on Amazon EKS",
    version="1.0.0",
)


@app.get("/")
def root():
    return {
        "message": "EKS Python API is running"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }


@app.get("/api/info")
def info():
    return {
        "application": "EKS Python API",
        "version": "1.0.0",
        "environment": "development"
    }