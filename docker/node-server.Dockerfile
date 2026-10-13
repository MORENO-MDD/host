FROM node:22-bookworm-slim
RUN useradd --create-home --uid 10001 appuser
WORKDIR /workspace
COPY --chown=appuser:appuser . /workspace
RUN if [ -f package.json ]; then npm install --omit=dev --no-audit --no-fund; fi
USER appuser
EXPOSE 8000
CMD ["node", "index.js"]
