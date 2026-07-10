#Frontend
FROM node:lts AS builder
WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm ci

COPY frontend/ ./
RUN npm run build


#Backend + Asamblare
FROM python:3.13-slim
WORKDIR /app/backend

COPY backend/*requirements.txt ./
RUN pip install --no-cache-dir -r dev-requirements.txt

COPY backend/ ./
COPY --from=builder /app/frontend/dist /app/frontend/dist

ENV HOST=0.0.0.0
EXPOSE 8000

CMD ["python", "-m", "app"]