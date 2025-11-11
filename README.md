# Forecast API

Ruby on Rails API that queries external providers for location lookup and weather forecasts. Responses are cached and exposed through endpoints ready to be consumed from the browser or automation clients.

## How It Works

Requests to third-party services are encapsulated under `app/external_api_clients`. Domain logic lives in `app/lib/forecasts`, where entities, repositories, and services orchestrate the external calls while keeping business rules isolated from HTTP concerns. This modular setup makes it simple to swap providers or evolve the domain without wide-reaching changes.

Each external call leverages `Rails.cache` to store responses per coordinate/address in a configurable grid, reducing latency and limiting calls to external APIs.

## Configuration

1. Copy the sample environment file:
   ```bash
   cp .env.sample .env
   ```
2. Edit `.env` and provide the credentials obtained from the external APIs:
   - `FORECASTS_API_BASE_URL`
   - `FORECASTS_API_KEY`
   - `LOCATIONS_API_BASE_URL`
   - `LOCATIONS_API_KEY`
3. Install dependencies:
   ```bash
   bundle install
   ```

## Running Locally

Start the development server once the environment variables are configured:
```bash
bin/dev
```
The API runs on the port reported by the process (defaults to `http://localhost:3000`). Endpoints defined in `config/routes.rb` can be exercised directly from the browser or any HTTP client.

## Automated Tests

Run the RSpec suite with:
```bash
bundle exec rspec
```
The test suite uses `VCR` to record and replay real interactions with the external APIs, ensuring deterministic runs without network access. Cassettes are stored under `spec/vcr`.

## Design Choices

- **Domain-centric abstractions**: entities and repositories in `lib/forecasts` isolate business rules from transport details.
- **Fewer mocks, more unit tests**: contracts between layers were designed to minimize unnecessary stubs. Whenever possible, tests exercise real objects to keep them truly unitary and easy to maintain.
- **Configurable caching**: grid resolution and expiration live within the external clients, making it easy to balance freshness versus cost when tuning the system.
