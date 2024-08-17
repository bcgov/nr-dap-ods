# Set up Meltano CLI

```sh
python3 -m pip install --user pipx

pipx install meltano

pipx ensurepath
```

## Run with Docker

Link: <https://docs.meltano.com/guide/containerization/>

```sh
mkdir projects

docker run -v .:/projects -w /projects meltano/meltano
```

## Set up a new Meltano replication job

```sh
meltano init odsdev

cd ods-dev

meltano add extractor tap-rest-api-msdk

meltano config tap-rest-api-msdk set --interactive

meltano invoke tap-rest-api-msdk

meltano select tap-rest-api-msdk --list --all

meltano add loader target-postgres

meltano config target-postgres set --interactive

meltano invoke target-postgres

meltano select target-postgres --list --all
```

## Required Parameters

For PostgreSQL:
3. database
11. host
14. password
15. port
32. user

For (public) API:
3. API endpoint
34. path

## Notes

- make sure to also set default_target_schema
- secrets automatically go to .env file
- --interactive allows you to semi-interactively set up the source and target details
