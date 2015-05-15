Imgupl [![Build Status](https://travis-ci.org/lukad/imgupl.svg?branch=develop)](https://travis-ci.org/lukad/imgupl) [![Code Climate](https://codeclimate.com/github/lukad/imgupl/badges/gpa.svg)](https://codeclimate.com/github/lukad/imgupl)
======

Fancy image upload platform.

![](screenshot.png)

## Features

* [x] Upload images (duh)
* [ ] Comment uploads
* [ ] Rate uploads
* [ ] Tag uploads
* [x] Role system (guest, user, mod, admin)

## Configuration

The app is configured with the following environment variables.

| variable                   | description              | default      | required |
|----------------------------|--------------------------|--------------|:--------:|
| `APP_ROOT_PREFIX`          | App root prefix          |              |          |
| `DATABASE_CONNECTION_POOL` | Postgres connection pool | 5            |          |
| `DATABASE_DB`              | Posgres database name    |              | ✓        |
| `DATABASE_USERNAME`        | Postgres username        | current user |          |
| `DATABASE_HOST`            | Postgres host            | localhost    |          |
| `DATABASE_PORT`            | Postgres port            | 5432         |          |
| `DATABASE_PASSWORD`        | Postgress password       |              |          |
| `SECRET_KEY_BASE`          | Secret key base          |              | ✓        |

You can generate a secret key used for `SECRET_KEY_BASE` by running `bundle exec rake secret`.

## Hacking

Create a `.env` file containing all the required configuration parameters.

Example:
```
DATABASE_DB='imgupl'
SECRET_KEY_BASE='539b24987a0428233bbd300cc18068ad93f180fc8a0bd3e98356be340570b3e6ef44f656bf940e9813646b755cc70b1243162011576147a642b773dce6e1ee7e'
```

Run `bundle exec unicorn -p 3000` and visit [](http://localhost:3000)

## Contributing

1. Fork it ( https://github.com/lukad/imgupl/fork )
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Run the tests `bundle exec rspec`
4. Commit your changes (`git commit -am ':boom: add some feature'`)
5. Push to the branch (`git push origin feature/my-new-feature`)
6. Create a new Pull Request
