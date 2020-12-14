FROM python:latest
WORKDIR /code
COPY . /code
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt



RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh

EXPOSE 5000

ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

CMD ["python", "app.py", "runserver", "--host=0.0.0.0", "--threaded"]