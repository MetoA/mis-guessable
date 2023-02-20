CREATE TABLE users
(
    id       BIGSERIAL PRIMARY KEY NOT NULL,
    username TEXT                  NOT NULL UNIQUE,
    password TEXT                  NOT NULL
);

CREATE TABLE locations
(
    id         BIGSERIAL PRIMARY KEY NOT NULL,
    latitude   DOUBLE PRECISION      NOT NULL,
    longitude  DOUBLE PRECISION      NOT NULL,
    image      BYTEA                 NOT NULL,
    created_by BIGINT references users (id)
);

CREATE TABLE guesses
(
    id                BIGSERIAL PRIMARY KEY NOT NULL,
    location          BIGINT REFERENCES locations (id),
    guessed_by        BIGINT REFERENCES users (id),
    guessed_latitude  DOUBLE PRECISION      NOT NULL,
    guessed_longitude DOUBLE PRECISION      NOT NULL,
    distance          DOUBLE PRECISION      NOT NULL
);
