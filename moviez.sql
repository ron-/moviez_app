create table moviez
  (
    id serial8 primary key,
    title varchar(50) not null,
    year char(4),
    rated varchar(10),
    runtime varchar(10),
    genre varchar(50),
    director varchar(50),
    writer varchar(50),
    actors varchar(100),
    plot text
  );