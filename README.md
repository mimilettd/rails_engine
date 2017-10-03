# Rails Engine

The Rails Engine API allows you to query metadata and perform business analytics on merchants, invoices, invoice items, items, customers, and transactions. The return format for all endpoints is JSON.

## Base URL

All URLs referenced in this documentation have the following base:

```
http://localhost:3000
```
You can override this by
passing a `BASE_URL` environment variable:

```
BASE_URL=http://my-app-url.com rake
```

## Getting Started
<b><i>This section will help you get started with our API.</i></b>

### Prerequisites

You're going to need:
  * Ruby, version 2.3.1 or newer
  * Bundler

### Getting Set Up

1. Fork this repository on Github.

2. Clone your forked repository (not our original one) to your hard drive with

```
git clone https://github.com/mimilettd/rails_engine
```
3. `cd rails_engine`

4. Initialize Rails Engine locally:

```
bundle install
rails s
```

5. Create, migrate, and seed your database:

```
rake db:create
rake db:migrate
rake db:seed
```
## Sample Responses

Below are some sample responses for some typical calls to the Rails Engine API. Responses will return an Object or a list of Objects depending on the End Point:
