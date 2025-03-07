# LocalSync


## Setup
* Ruby 3.4.2
* Postgres >= 16

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

To trigger a full sync, you can use the following API call:
```bash
curl -X POST http://localhost:5000/spaces/yadj1kx9rmg0/full_sync
```

To trigger a delta update sync, you can use the following API call:
```bash
curl -X POST http://localhost:5000/spaces/yadj1kx9rmg0/sync
```

## Testing

To run the tests, you can use the following command:
```bash
bin/rails test
```

## Considerations

* Some obvious things are missing like token encryption and pagination in the entries endpoint. While they are important, I believe that this is out of scope for this project (and don't impact my presentation).
* In a real world scenario, I would probably spend more time normalizing the data (e.g. `fields`). I know that this are customer-provided data hence they don't really have a pattern and normalizing them would be hard and would take a lot of time'.
* While I didn't normalize `fields`, I maintained the links between entries/assets (see on `app/models/entry.rb#L14`).
* Some other production features would be needed in a real world scenario like:
  * Logging
  * Monitoring
  * Rate limiting
  * Caching
