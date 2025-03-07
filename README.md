# LocalSync

## Development

```bash
bundle install
bin/rails db:create db:migrate db:seed
```

## Running the server

```bash
bin/dev
```

## Operating the API

To see all the entries for a space, you can use the following endpoint:
```bash
http://localhost:5000/spaces/yadj1kx9rmg0/entries
```

To trigger a full sync, you can use the following endpoint:
```bash
curl -X POST http://localhost:5000/spaces/yadj1kx9rmg0/full_sync
```

To trigger a delta update sync, you can use the following endpoint:
```bash
curl -X POST http://localhost:5000/spaces/yadj1kx9rmg0/sync
```
