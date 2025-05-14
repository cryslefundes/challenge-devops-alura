FROM python:3.10-alpine3.21 AS builder

WORKDIR /app

COPY src/requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

FROM python:3.10-alpine3.21

COPY --from=builder /usr/local/lib/python3.10/site-packages/ /usr/local/lib/python3.10/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

RUN addgroup -S appuser && adduser -S appuser -G appuser && mkdir app && chown -R appuser /app

WORKDIR /app

COPY --chown=appuser:appuser src /app/src

COPY --chown=appuser:appuser launch.sh .

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

EXPOSE 8000

USER appuser

CMD ["sh", "launch.sh"]