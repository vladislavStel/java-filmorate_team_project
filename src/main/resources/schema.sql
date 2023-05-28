DROP TABLE IF EXISTS USERS, FRIEND_LIST, FILM, LIKE_LIST, GENRE_LIST, GENRE, MPA, REVIEW, REVIEW_LIKE, DIRECTOR_LIST, DIRECTOR;

CREATE TABLE IF NOT EXISTS USERS (
    user_id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    login varchar(50) NOT NULL,
    name varchar(50) NOT NULL,
    birthday date,
    email varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS FRIEND_LIST (
    user_id bigint REFERENCES USERS (user_id) ON DELETE CASCADE,
    friend_id bigint REFERENCES USERS (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS MPA (
    mpa_id int PRIMARY KEY,
    name varchar(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS FILM (
    film_id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(50) NOT NULL,
    description varchar(200) NOT NULL,
    releaseDate date,
    duration int CHECK (duration > 0),
    mpa_id int REFERENCES MPA (mpa_id)
);

CREATE TABLE IF NOT EXISTS LIKE_LIST (
    film_id bigint REFERENCES FILM (film_id) ON DELETE CASCADE,
    user_id bigint REFERENCES USERS (user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS GENRE (
    genre_id int PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS GENRE_LIST (
    film_id bigint REFERENCES FILM (film_id) ON DELETE CASCADE,
    genre_id int REFERENCES GENRE (genre_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS REVIEW (
    review_id bigint GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content varchar NOT NULL,
    is_positive boolean,
    user_id bigint NOT NULL REFERENCES USERS (user_id) ON DELETE CASCADE,
    film_Id bigint NOT NULL REFERENCES FILM (film_id) ON DELETE CASCADE,
    useful int
);

CREATE TABLE IF NOT EXISTS REVIEW_LIKE (
    review_id bigint REFERENCES REVIEW (review_id) ON DELETE CASCADE,
    user_id bigint REFERENCES USERS (user_id) ON DELETE CASCADE,
    is_like boolean
);

CREATE TABLE IF NOT EXISTS DIRECTOR (
    director_id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS DIRECTOR_LIST(
    film_id bigint REFERENCES FILM (film_id) ON DELETE CASCADE,
    director_id int REFERENCES DIRECTOR (director_id) ON DELETE CASCADE
);