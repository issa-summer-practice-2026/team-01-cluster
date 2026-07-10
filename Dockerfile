#Frontend
FROM node:lts AS builder
WORKDIR /proiect/frontend

COPY frontend/ ./
RUN npm ci
RUN npm run build

#Backend + Asamblare
FROM python:3.13-slim
WORKDIR /proiect

COPY backend/*requirements.txt ./backend/
RUN pip install --no-cache-dir -r backend/dev-requirements.txt

COPY backend/ ./backend/
COPY --from=builder /proiect/frontend/dist ./frontend/dist

ENV HOST=0.0.0.0
EXPOSE 8000

WORKDIR /proiect/backend
CMD ["python", "-m", "app"]