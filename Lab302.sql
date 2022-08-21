-- Normalize the following blog database and write the DDL scripts to create the database tables:

create database exercise1; -- crea base de datos

use exercise1; -- usamos base de datos

drop table if exists author, title; -- borramos las tablas si existen

-- creamos la tabla author
CREATE TABLE `exercise1`.`author` (
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT references title(author_id),
  `author_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
  );

-- creamos la tabla con los titulos
CREATE TABLE `exercise1`.`title` (
	`author_id` INT NOT NULL,
    `title_name` VARCHAR(255) NOT NULL,
    `word_count` INT NOT NULL,
    `views` INT NOT NULL);

-- añado valores a la tabla autores    
insert into author (author_name) values ('Maria Charlotte'),('Juan Perez'),('Gemma Alcocer');

-- muestro la tabla autores
select * from author;

-- añado valores a la tabla titulos
insert into title (author_id, title_name, word_count, views) values (1, "Best Paint Colors", 814, 14), (2, "Small Space Decorating Tips", 1146, 221),
(1, "Hot Accessories", 986, 105), (1,"Mixing Textures", 765, 22), (2, "Kitchen Refresh", 1242, 307), (1, "Homemade Art Hacks", 1002, 193),
(3,	"Refinishing Wood Floors", 1571, 7542);

select * from title;



-- Normalize the following airline database and write the DDL scripts to create the database tables:
create database exercise2; -- crea base de datos

use exercise2; -- usamos base de datos

drop table if exists customer, flight, milage;

CREATE TABLE `exercise2`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT references milage(customer_id),
  `customer_name` VARCHAR(255) NOT NULL,
  `customer_status` VARCHAR (255) NOT NULL,
  `flight_number` VARCHAR(255) NOT NULL references flight(flight_number_id),
  `total_customer_milage` INT NOT NULL,
  PRIMARY KEY (`id`)
  );
  
CREATE TABLE `exercise2`.`flight` (
  `flight_number_id` VARCHAR(255) UNIQUE NOT NULL,
  `aircraft` VARCHAR(255) NOT NULL,
  `aircraft_seats` INT NOT NULL,
  `flight_milage` INT NOT NULL,
  PRIMARY KEY (`flight_number_id`)
  );
  
  
insert into customer (customer_name, customer_status, flight_number, total_customer_milage) values 
('Agustine Riviera','Silver','DL143', 115235),
('Agustine Riviera','Silver','DL122', 115235),
('Alaina Sepulvida','None','DL122', 6008), 
('Agustine Riviera','Silver','DL143', 115235), 
('Tom Jones','Gold','DL122', 205767), 
('Tom Jones','Gold','DL53', 205767), 
('Agustine Riviera','Silver','DL143', 115235),
('Sam Rio', 'None', 'DL143', 2653), 
('Agustine Riviera','Silver','DL143', 115235), 
('Tom Jones','Gold','DL222',205767), 
('Jessica James', 'Silver','DL143', 127656), 
('Sam Rio', 'None', 'DL143', 2653),
('Ana Janco','Silver','DL222', 136773), 
('Jennifer Cortez','Gold','DL222', 300582), 
('Jessica James', 'Silver','DL122', 127656),
('Sam Rio', 'None', 'DL37', 2653), 
('Christian Janco','Silver','DL222', 14642);

insert into flight (flight_number_id, aircraft, aircraft_seats, flight_milage) values 
('DL143','Boeing 747', 400, 135), 
('DL122','Airbus A330',236, 4370), 
('DL53','Boeing 777',264,2078), 
('DL222','Boeing 777', 264, 1765), 
('DL37', 'Boeing 747', 400, 531);


-- In the Airline database write the SQL script to get the total number of flights in the database.
select count(flight_number_id) from flight;

-- In the Airline database write the SQL script to get the average flight distance.
select avg(flight_milage) from flight;

-- In the Airline database write the SQL script to get the average number of seats.
select avg(aircraft_seats) from flight;

-- In the Airline database write the SQL script to get the average number of miles flown by customers grouped by status.
select customer_status, avg(total_customer_milage) from customer group by customer_status;

-- In the Airline database write the SQL script to get the maximum number of miles flown by customers grouped by status.
select max(total_customer_milage), customer_status from customer group by customer_status;

-- In the Airline database write the SQL script to get the total number of aircraft with a name containing Boeing.
select count(aircraft) from flight where aircraft like "%Boeing%";

-- In the Airline database write the SQL script to find all flights with a distance between 300 and 2000 miles.
select flight_number_id, aircraft, flight_milage from flight where flight_milage >=300 and flight_milage <=2000;

-- In the Airline database write the SQL script to find the average flight distance booked grouped by customer status (this should require a join).
select distinct(customer_status), avg(flight_milage)
from customer
inner join flight
on customer.flight_number = flight.flight_number_id
group by customer_status;

-- In the Airline database write the SQL script to find the most often booked aircraft by gold status members (this should require a join).
select customer_status, max(aircraft)
from customer
inner join flight
on customer.flight_number = flight.flight_number_id
where customer_status ="Gold"
order by aircraft;
