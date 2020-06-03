/* PRACTICE JOINS */

-- number 1
select * 
from invoice
join invoice_line on invoice_line.invoice_id = invoice.invoice_id
where invoice_line.unit_price > 0.99;

-- number 2
select invoice_date, first_name, last_name, total
from invoice
join customer on invoice.customer_id = customer.customer_id

-- number 3
select customer.first_name, customer.last_name, employee.first_name, employee.last_name
from customer
join employee on customer.support_rep_id = employee.employee_id

-- number 4
select album.title, artist.name
from album
join artist on album.artist_id = artist.artist_id

-- number 5
select track_id
from playlist_track
join playlist on playlist.playlist_id = playlist_track.playlist_id
where playlist.name = 'Music'

-- number 6
select track.name
from track
join playlist_track on playlist_track.track_id = track.track_id
where playlist_track.playlist_id = 5;

-- number 7 
select track.name, playlist.name
from track
join playlist_track on playlist_track.track_id = track.track_id
join playlist on playlist.playlist_id = playlist_track.playlist_id

-- number 8 
SELECT track.name, album.title
FROM track 
JOIN album  ON track.album_id = album.album_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Alternative & Punk';


/* Nested Queries */

-- number 1
select * from invoice
where invoice_id in (
  select invoice_id from invoice_line
  where unit_price > 0.99
  );

-- number 2
select * from playlist_track
where playlist_id in (
  select playlist_id from playlist
  where name = 'Music'
);

-- number 3
select name from track
where track_id in (
  select track_id from playlist_track
  where playlist_id = 5
);

-- number 4
select * from track
where genre_id in (
  select genre_id from genre
  where name = 'Comedy'
);

-- number 5
select * from track
where album_id in (
  select album_id from album
  where title = 'Fireball'
);

-- number 6
select * from track
where album_id in (
  select album_id from album
  where artist_id in (
    select artist_id from artist
    where name = 'Queen'
  )
);


/* UPDATE ROWS */

-- number 1
update customer
set fax = null
where fax is not null;

-- number 2
update customer
set company = 'Self'
where company is null

-- number 3
UPDATE customer 
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- number 4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- number 5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;


/* GROUP BY */

-- number 1
select count(*), genre.name
from track 
join genre on track.genre_id = genre.genre_id
group by genre.name

-- number 2
select count(*), genre.name
from track
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock' or genre.name = 'Pop'
group by genre.name

-- number 3
select count(*), artist.name
from artist
join album on artist.artist_id = album.artist_id
group by artist.name


/* DISTINCT */

-- number 1
select distinct composer from track

-- number 2
select distinct billing_postal_code from invoice

-- number 3
select distinct company from customer


/* DELETE ROWS */

-- number 2
delete from practice_delete 
where type = 'bronze'

-- number 3
delete from practice_delete 
where type = 'silver'

-- number 4
delete from practice_delete 
where value = 150


/* ECOMMERCE */

-- creating tables
create table users (
  user_id serial primary key,
  name varchar(40),
  email varchar(60)
);

create table products (
  product_id serial primary key,
  name varchar(40),
  price integer
);

create table orders (
  order_id serial primary key,
  product_id integer references products(product_id)
);

insert into users (name, email)
values ('Eliott', 'en@gmail.com'),
('Spencer', 'spiff@gmail.com'),
('Rylee', 'rylee@yahoo.com');

insert into products (name, price)
values ('golf balls', 10),
('blankets', 15),
('hat', 7);

insert into orders (product_id)
values (1), (1), (2), (3), (3), (3);

-- run queries
select * from orders where order_id = 1

select * from orders

select sum(products.price) from orders
join products on products.product_id = orders.product_id
where orders.order_id = 1

-- add foreign key
alter table orders
add column user_id
type references users(user_id)

update orders
set user_id = 1
where order_id = 1

update orders
set user_id = 2
where order_id = 3

update orders
set user_id = 2
where order_id = 4

update orders
set user_id = 3
where order_id = 6

update orders
set user_id = 3
where order_id = 5

update orders
set user_id = 3
where order_id = 2

--  more queries
select * from orders
join users on users.user_id = orders.user_id
where user_id = 2

select count(*) from orders
join users on users.user_id = orders.user_id