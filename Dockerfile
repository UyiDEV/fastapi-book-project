FROM python:3.9-slim as builder

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /app /app

RUN apk add --no-cache python3 py3-pip

WORKDIR /app

COPY requirements.txt .
RUN pip3 install -r requirements.txt

EXPOSE 80

CMD sh -c "uvicorn main:app --host 0.0.0.0 --port 8000 & nginx -g 'daemon off;'"