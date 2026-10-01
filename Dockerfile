FROM python:3.12-slim

WORKDIR /app

COPY english_supervision_v08_final.zip /tmp/project.zip

RUN python -c "import zipfile; zipfile.ZipFile('/tmp/project.zip').extractall('/app')" \
    && rm /tmp/project.zip

RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_DEBUG=0
ENV PORT=10000

EXPOSE 10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "--workers", "2", "app:app"]
