FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1
RUN useradd --create-home --uid 10001 appuser
WORKDIR /workspace
COPY --chown=appuser:appuser . /workspace
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir --no-compile -r requirements.txt; fi
USER appuser
EXPOSE 8000
CMD ["python3", "main.py"]
