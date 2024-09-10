FROM meltano/meltano:v3.5-python3.12

RUN bash -c 'mkdir -p /app/ods-dev/{analyze,extract,load,notebook,orchestrate,output,transform}'

WORKDIR /app

COPY ods-dev .

CMD ["--help"]
