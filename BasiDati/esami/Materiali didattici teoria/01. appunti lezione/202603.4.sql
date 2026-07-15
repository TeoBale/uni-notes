-- appunti lezione del 20260323
-------------------------------

-- operatori aggregati
--- min(<attributo>)
--- max(<attributo>)
--- sum(<attributo>)
--- avg(<attributo>) 
--- count(*), 
--- count(<attributo>),
--- count(distinct <attributo>)

-- selezionare il film di durata maggiore/minore
select max(length) as max_length
from imdb.movie; 

select min(length) as min_length
from imdb.movie; 

-- restituire il titolo dei film con durata massima/minima
with max_length as (
select max(length) as max_length
from imdb.movie)
select movie.*
from imdb.movie inner join max_length on movie.length = max_length;

with min_length as (
select min(length) as length
from imdb.movie)
select movie.*
from imdb.movie natural join min_length;

-- usiamo max per trovare il thriller con la valutazione più elevata
with thrillers as (
select *
from imdb.genre g 
where genre = 'Thriller'
), thrillers_rating as (
select rating.*, score/scale as evaluation
from imdb.rating natural join thrillers),
max_rating as (
select max(evaluation) as max_eval
from thrillers_rating)
select movie.*
from thrillers_rating tr inner join max_rating mr on tr.evaluation = mr.max_eval inner join imdb.movie on movie.id = tr.movie;


-- restituire la durata media delle pellicole
-- avg ignora i valori nulli
select avg(length) 
from imdb.movie 

-- restituire la durata complessiva delle pellicole del 2010
select sum(length)
from imdb.movie 
where year = '2010';

-- restituire durata complessiva e durata massima e durata media delle pellicole del 2010
select sum(length), max(length), avg(length)
from imdb.movie 
where year = '2010';

-- in una query con operatori aggregati, la clausola di proiezione può contenere solo i) operatori aggregati, o ii) attributi inclusi in una clausola di raggruppamento (GROUP BY)


-- restituire il numero di pellicole memorizzate
-- count(*) restituisce la cardinalità di una relazione  
select count(*)
from imdb.movie; 

-- restituire il numero di pellicole del 2010
select count(*)
from imdb.movie
where year = '2010';

-- restituire il numero di pellicole per le quali è noto il titolo
-- count(official_title) conta il record di movie solo se il valore di official_title non è null
select count(official_title)
from imdb.movie

-- confronto count(*) con count(<attributo>)
select count(*), count(official_title), count(length)
from imdb.movie

-- restituire il numero di titoli diversi delle pellicole
select count(*), count(official_title), count(distinct official_title)
from imdb.movie

-- trovare le pellicole con il medesimo titolo
-- soluzione con join (restituiamo le coppie di film con lo stesso titolo)
select m1.id, m1.official_title, m2.id, m2.official_title
from imdb.movie m1 inner join imdb.movie m2 on m1.official_title = m2.official_title and m1.id > m2.id 
order by m1.official_title, m1.id, m2.id

-- come si considera il null nelle operazioni di avg e count
-- il rapporto sum(length)/count(length) produce un risultato di tipo integer perchè l'attributo length è integer. Per avere un risultato con la parte decimale nel risultato faccio un casting a numeric di sum(length)
-- round arrotonda il risultato al numero di decimali desiderato
-- count(*) include i record con null sull'attributo length
select avg(length) as avg_length, round(sum(length)::numeric/count(length), 2) as sum_on_count, round(sum(length)::numeric/count(*), 2) as avg_with_nulls
from imdb.movie 
where year = '2010';

-- restituire il numero di pellicole per ogni anno disponibile (con ordinamento)
select year, count(*) as movie_number 
from imdb.movie 
group by year
-- order by year desc; 
-- order by movie_number DESC
-- la seguente clausola ordina il risultato in base alla posizione degli attributi nella clausola di proiezione (select). In questo caso si ordina in base al secondo attributo in modo decrescente
order by 2 desc;


-- restituire per ciascun film il numero di persone coinvolte per ciascun ruolo
crew(person, movie, p_role) - PK(person,movie,p_role)
select movie, p_role, count(*), count(person), count(distinct person)
from imdb.crew 
group by p_role, movie
order by movie;

-- restituire per ogni persona il numero di film in cui partecipa
select person, count(*), count(movie), count(distinct movie)
from imdb.crew 
group by person 

-- restituire il nome delle persone e il numero di film in cui partecipa 
select person, given_name, count(*)
from imdb.crew inner join imdb.person on crew.person = person.id 
group by person, given_name  

-- quando l'attributo usato nella clausola di raggruppamento è una chiave (person in questo caso), l'aggiunta di attributi dipendenti dalla chiave (given_name in questo caso) non cambia i raggruppamenti
 

-- per ogni film restituire la numerosità del cast e il titolo del film 
select id, official_title, count(*) 
from imdb.crew c inner join imdb.movie on movie.id = c.movie 
group by movie.id, official_title 


-- la seguente query non è equivalente alla precedente
-- film diversi con lo stesso titolo sarebbero raggruppati nello stesso insieme
select official_title, count(*) 
from imdb.crew c inner join imdb.movie on movie.id = c.movie 
group by official_title 

-- i tre record sarebbero nello stesso gruppo anche se riguardano due film diversi
movie | movie.id  | official_title
===================================
001 	001				Batman 
001		001				Batman 
002		002             Batman

-- restituire il numero di generi di ciascun film
genre(movie, genre) PK(movie,genre)
select movie, count(*), count(genre), count(distinct genre)
from imdb.genre
group by movie;


-- restituire il numero di pellicole di genere thriller o drama
select genre, count(*)
from imdb.genre 
where genre in ('Thriller', 'Drama')
group by genre; 

-- se potessimo avere generi con differenze sul case delle lettere dovremmo usare la funzione lower
select lower(genre), count(*)
from imdb.genre 
where lower(genre) in ('thriller', 'drama')
group by lower(genre) 

-- i due record di drama/Drama sarebbero raggruppati nello stesso insieme
genre
========
movie | genre
=============
001		Drama 
001     drama 
003     Thriller 


-- restituire la durata media delle pellicole per ogni anno (con ordinamento)
select year, avg(length) as avg_movie_length
from imdb.movie 
group by year;

-- restituire il numero di persone per ruolo
select p_role, count(person)
from imdb.crew
group by p_role 

-- restituire le pellicole che hanno più di 10 attori
select movie, count(person)
from imdb.crew c
where p_role = 'actor' 
group by movie 
having count(person) > 10 

-- soluzione con cte
with person_by_movie as (
select movie, count(person) as person_count
from imdb.crew c
where p_role = 'actor' 
group by movie)
select *
from person_by_movie
where person_count > 10;

-- la seguente query non ha senso 
-- non posso esprimere nella WHERE condizioni che riguardano i gruppi
select movie, count(person)
from imdb.crew c
where p_role = 'actor'  and count(person) > 10 
group by movie;

-- la seguente query non ha altrettanto senso
-- non posso esprimere nella HAVING condizioni che riguardano i singoli record
select movie, count(person)
from imdb.crew c
group by movie 
having count(person) > 10  and p_role = 'actor' 

-- restituire le persone che hanno svolto più di un ruolo
select person, count(distinct p_role)
from imdb.crew 
group by person 
having count(distinct p_role) >= 2

crew
====
person | movie | p_role
=======================
001		 001		actor
002		 001		director 
001      001		producer
002		 003		actor
003		 001		actor
003		 002        actor

-- restituire le persone che hanno svolto più di un ruolo nel medesimo film 
-- la clausola distinct nel count non serve in questo caso perchè una persona non può partecipare a un film due volte con lo stesso ruolo
select person, count(p_role)
from imdb.crew 
group by person, movie 
having count(p_role) >= 2

-- restituire gli anni nei quali ci sono più di 10 film a partire dal 2010


-- appunti lezione del 20260325
-------------------------------
-- per ogni genere, trovare quanti film sono associati
select genre, count(*)
from imdb.genre 
group by genre;

-- per ogni persona, trovare quanti film ha diretto (includere anche le persone a contatore zero)
with directors as (
select *
from imdb.crew c
where p_role = 'director')
select person.id, count(movie), count(*)
from directors right join imdb.person on person.id = person
group by person.id  
-- having count(movie) = 0;

-- le persone 002 e 003 devono apparire nel risultato con count = 0
person | movie | p_role | person.id | given_name | ... 
======================================================
001		 ABC	     dir.      001		   gn1  *
[NULL]  [null]  [null]     003     	   gn3 
[NULL]  [null]  [null]     002     	   gn2 


-- soluzione alternativa 
select person.id, count(movie)
from imdb.crew c right join imdb.person on person.id = c.person and p_role = 'director' 
group by person.id 
having count(movie) = 0;

-- questa soluzione non è corretta: una persona può avere ruoli sempre diversi da director e restare esclusa dalla condizione di selezione di where
select person.id, count(movie)
from imdb.crew c right join imdb.person on person.id = c.person where p_role = 'director' or p_role is null
group by person.id 


-- per ogni paese, restituire il numero di film prodotti in quel paese (inclusi i paesi dove non sono prodotti film)


-- per ogni film, restituire il numero di materiali di quel film (inclusi i film senza materiali)
-- prestare attenzione al risultato errato prodotto da count(*): le righe spurie vengono erroneamente contate
select movie.id, count(material.movie), count(*)
from imdb.movie left join imdb.material on movie.id = material.movie 
group by movie.id 
-- having count(movie) = 0


-- per ogni film, restituire il numero di persone coinvolte in ogni ruolo 
-- includere le pellicole per le quali non abbiamo corrispondenze in crew
-- includere per ogni pellicola tutti i ruoli anche quelli che hanno count = 0
with roles as (
select distinct p_role as role_name
from imdb.crew c
), movies_per_roles as (
select *
from roles, imdb.movie 
), role_counts as (
select movie, p_role, count(*) as c 
from imdb.crew 
group by movie, p_role
)
select id, role_name, coalesce(c, 0) as c
from movies_per_roles mr left join role_counts rc on (mr.id = rc.movie and mr.role_name = rc.p_role)
-- where c is null 
-- where coalesce(c, 0) = 0

-- soluzione con join esterno senza coalesce
with roles as (
select distinct p_role as role_name
from imdb.crew c
), movies_per_roles as (
select *
from roles, imdb.movie 
)
select id, role_name, count(person) as c 
from movies_per_roles mr left join imdb.crew c on (mr.id = c.movie and mr.role_name = c.p_role)
group by mr.id, mr.role_name

-- soluzione con join esterno senza coalesce usando cross join (equivalente a prodotto cartesiano)
-- https://www.postgresql.org/docs/current/queries-table-expressions.html
with roles as (
select distinct p_role as role_name
from imdb.crew c
)
select id, role_name, count(movie)
from roles cross join imdb.movie m left join imdb.crew c on m.id = c.movie and role_name = c.p_role
group by m.id, role_name
-- having count(movie) = 0
order by m.id


-- esempio
movie | person | p_role | movie.id | title
==========================================
ABC		001		actor	  ABC		 t1
ABC		001		dir.	  ABC		 t1
BCD	    002		actor	  BCD	     t2
BCD	    003		actor	  BCD	     t2
[null]	[null]	[null]	  CDE		 t3	

-- output atteso delle query
movie | role | count
====================
ABC		actor 	1
ABC     dir.    1
ABC		prod.   0
ABC		writ.   0
BCD		actor 	2
BCD     dir.    0
BCD		prod.   0
BCD		writ.   0
CDE		actor 	0
CDE     dir.    0
CDE		prod.   0
CDE		writ.   0


-- selezionare l'attore che ha recitato nel maggior numero di film
-- questa soluzione produce un errore nel dbms: non è possibile applicare un operatore aggregato a un altro operatore aggregato
select person, max(count(*))
from imdb.crew c 
where p_role = 'actor'
group by person 

-- soluzione con cte
with p_counts as (
select person, count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person 
), max_movies as (
select max(movie_number) as max_number
from p_counts
)
select *
from p_counts 
where movie_number = (select max_number from max_movies);

-- sintassi alternativa 
with p_counts as (
select person, count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person 
)
select *
from p_counts
where movie_number = 
(select max(movie_number) as max_number
from p_counts)

-- altra sintassi ancora 
with p_counts as (
select person, count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person 
), max_movies as (
select max(movie_number) as max_number
from p_counts
)
select p_counts.*
from p_counts, max_movies
where p_counts.movie_number = max_movies.max_number 

-- ultima variante di soluzione 
select person, count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person 
having count(*) >= all (
select count(*)
from imdb.crew c 
where p_role = 'actor'
group by person)


crew
movie | person | p_role
ABC		001		 actor
ABC		002		 actor
BCD		001		 actor
CDE		001		 actor
ABC		003		 actor
BCD		002		 actor

select person, count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person

person | movie_number
001		3 *
002		2
003		1
004     3 *

select count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person

movie_number
3
2
1
3

-- la seguente NON è una soluzione corretta: non funziona quando ho più persone che hanno lo stesso valore massimo di film interpretati
select person, count(*) as movie_number
from imdb.crew c 
where p_role = 'actor'
group by person
order by 2 desc
limit 1

-- trovare il paese nel quale sono stati prodotti il maggior numero di film


-- trovare il film che possiede il maggior numero di materiali
select movie, count(*)
from imdb.material m 
group by movie 
having count(*) >= all (
select count(*)
from imdb.material m 
group by movie);

-- trovare il film che possiede il minor numero di materiali
select movie, count(*)
from imdb.material m 
group by movie 
having count(*) <= all (
select count(*)
from imdb.material m 
group by movie);

-- una risposta più corretta richiede di considerare anche le pellicole che non hanno materiali (se ce ne fossero)
select movie.id, count(movie)
from imdb.material right join imdb.movie on material.movie = movie.id 
group by movie.id  
having count(movie) <= all (
select count(movie)
from imdb.material right join imdb.movie on material.movie = movie.id 
group by movie.id);

-- trovare il paese nel quale sono stati prodotti il maggior numero di film thriller
-- produced(movie, country)
-- genre(movie, genre)
with thrillers as (
select movie
from imdb.genre
where genre = 'Thriller'), 
country_thrillers as (
select thrillers.movie, country
from thrillers inner join imdb.produced on thrillers.movie = produced.movie)
select country, count(movie)
from country_thrillers
group by country 
having count(*) >= all (
select count(*)
from country_thrillers
group by country 
);

-- selezionare i film con cast più numeroso della media
-- trovare la numerosità media dei cast e restituire le pellicole la cui numerosità è superiore
with cast_size as (
select movie, count(distinct person) as p_number
from imdb.crew 
group by movie 
), avg_cast as (
select avg(p_number) as avg_number
from cast_size
)
select *
from cast_size
where p_number > (select avg_number from avg_cast)


-- restituire il miglior rating di ciascun film

rating 
movie | scale | score
001		10		8
002		10		7
003		10		6 
002		10		8
001		10		9 

-- output atteso 
movie | scale | score 
003		10		6  *
002		10		8  *
001		10		9  *


select movie, max(score/scale)
from imdb.rating 
group by movie  

-- soluzione senza max usando query correlate
-- scorro i record di rating e restituisco un rating se non esiste un altro record di rating relativo alla stessa pellicola con una valutazione più alta (not exists)
with evaluations as (
select movie, score/scale as eval
from imdb.rating)
select *
from evaluations r1 
where not exists (
select *
from evaluations r2
where r1.movie = r2.movie and r2.eval > r1.eval)

-- Trovare le persone che hanno partecipato ad almeno due film distinti usciti nello stesso anno.
-- nell'esempio solo la persona 002 va nel risultato
person | movie | year 
001		 ABC		 2020
001		 BCD		 2021
002		 ABC         2020
002		 CDE	     2020

with crew_years as (
select crew.*, year
from imdb.crew inner join imdb.movie on crew.movie = movie.id 
)
select 
from crew_years cy1 inner join crew_years cy2 on cy1.person = cy2.person 
where cy1.movie > cy2.movie and cy1.year = cy2.year; 

-- soluzione alternativa (che richiede modifiche minime se invece di 2 film voglio considerare una soglia più alta per la quale la soluzione con self-join sarebber più complessa da scrivere)
with crew_years as (
select crew.*, year
from imdb.crew inner join imdb.movie on crew.movie = movie.id 
)
select person, year 
from crew_years
group by person, year 
having count(distinct movie) >= 2

-- soluzione alternativa 
-- restituire la persona p per la quale esiste una partecipazione ad un film m ed esiste una partecipazione a m1 con m1.year = m.year m1.id <> m.id 
with crew_years as (
select crew.*, year
from imdb.crew inner join imdb.movie on crew.movie = movie.id 
)
select p.*
from imdb.person p
where exists (
select *
from crew_years cy1 
where p.id = cy1.person and exists (
select *
from crew_years cy2
where p.id = cy2.person and cy1.movie <> cy2.movie and cy1.year = cy2.year 
));


-- appunti lezione del 20260326
-------------------------------
-- trovare i film che sono di genere comedy, romance e family
-- una possibile soluzione è basata su intersect 
-- cosa fare quando il numero di generi è maggiore? 
-- la soluzione con intersect diventa difficilmente gestibile
-- vediamo una soluzione basata su not exists (divisione in SQL)
-- devo trovare i film m1 per i quali non esiste genre g1 (comedy, romance e family) per il quale non trovo record in genre g2 dove movie = m1 e genre = g1
with genres as (
select distinct genre
from imdb.genre 
where genre in ('Family', 'Romance', 'Comedy')
) 
select m1.id, m1.official_title, m1.year 
from imdb.movie m1 
where not exists (
select *
from genres g1
where not exists (
select *
from imdb.genre g2
where g2.movie = m1.id and g2.genre = g1.genre 
)
)

select * from imdb.genre where movie = '0107438'


-- selezionare i film che non sono stati distribuiti nei paesi nei quali sono stati prodotti
-- questa soluzione non è corretta: il movie (003) dovrebbe essere escluso, ma entra nel risultato per il record 003-CHE che non ha corrispondenza in released
select p.movie 
from imdb.produced p
where not exists (
select *
from imdb.released r 
where p.movie = r.movie and p.country = r.country);

select country from imdb.produced where movie ='0048393';
select country from imdb.released where movie ='0048393' order by country;

produced
========
movie | country
001 	ITA
001		USA
002     USA 
003 	CHE
003	    ESP
003	    FRA

released 
========
movie | country
001 	 FRA
001		 GBR
002 	 USA 
002		 ITA
003	     ESP
003	     FRA

-- su questo esempio, l'unico film nel risultato è 001
-- soluzione corretta? verificare
select *
from imdb.produced p left join imdb.released r on p.movie = r.movie and p.country = r.country  
where r.movie is null; 

-- soluzione con exists
-- voglio un film m1 se non esiste un record di produced p1 relativo a m1 per il quale esiste il record di released relativo a m1 e allo stesso paese di p1
select m1.id, m1.official_title
from imdb.movie m1
where not exists (
select *
from imdb.produced p1
where m1.id = p1.movie and exists (
select *
from imdb.released r1
where r1.movie = m1.id and r1.country = p1.country))

-- corretta? verificare 
select m1.id, m1.official_title
from imdb.movie m1
where not exists (
select *
from imdb.produced p1 inner join imdb.released r1 on r1.movie = p1.movie and r1.country = p1.country
where m1.id = p1.movie)

-- corretta? verificare
select m1.id
from imdb.movie m1
except 
select p1.movie 
from imdb.produced p1 inner join imdb.released r1 on r1.movie = p1.movie and r1.country = p1.country


-- selezionare i film nel cui cast non figurano attori nati in paesi dove il film è stato prodotto

-- selezionare il titolo dei film che hanno valutazioni superiori alla media delle valutazioni dei film prodotti nel medesimo anno

-- selezionare i film con cast più numeroso della media dei film del medesimo genere

-- selezionare i film che sono stati distribuiti in tutti i paesi
-- un film m è nel risultato se non esiste un paese p per il quale non esiste la distribuzione di m in p

-- selezionare le persone che hanno recitato in tutti i film di genere Crime
-- data la persona A, non esiste un film di genere Crime in cui A non abbia recitato
-- se A ha recitato in tutti i movie Crime, non deve esistere un movie Crime per il quale non esiste la partecipazione di A
with crimes as (
select movie
from imdb.genre 
where genre = 'Crime')
select p.id, p.given_name 
from imdb.person p 
where not exists (
select 1
from crimes cr
where not exists (
select 1 
from imdb.crew c
where p.id = c.person and cr.movie = c.movie and p_role = 'actor'))

-- alternativa (potenzialmente meno costosa in termini di operazioni)
with crimes as (
select movie
from imdb.genre 
where genre = 'Crime'),
persons as (
select distinct person
from imdb.crew
where p_role = 'actor')
select p.id, p.given_name 
from persons p  
where not exists (
select 1
from crimes cr
where not exists (
select 1 
from imdb.crew c
where p.id = c.person and cr.movie = c.movie and p_role = 'actor'))


-- selezionare le coppie di attori che hanno recitato sempre insieme
-- vogliamo le coppia di persone x,y per le quali sono verificate le seguenti condizioni:
-- 1. non esiste film in cui recita x senza y (cioè NON ESISTE crew(m, x) per il quale NON ESISTE crew(m, y))
-- 2. non esiste film in cui recita y senza x (cioè NON ESISTE crew(m, y) per il quale NON ESISTE crew(m, x))
-- devo verificare entrambe altrimenti potrebbero esserci pellicole di y in cui non c'è x o viceversa
with actors as (
select distinct person
from imdb.crew
where p_role = 'actor'),
actor_pairs(p1,p2) as (
select p1.person, p2.person
from persons p1, persons p2
where p1.person > p2.person),
movie_cast as (select distinct person, movie from crew where p_role ='actor'),
select *
from actor_pairs ap
where 
-- NON ESISTE crew(m, p1) per il quale NON ESISTE crew(m, p2)
not exists (
select * 
from movie_cast c1
where c1.person = ap.p1 and not exists (
select * 
from movie_cast c2
where c2.person = ap.p2 and 
c2.movie = c1.movie)) 
-- NON ESISTE crew(m, p2) per il quale NON ESISTE crew(m, p1)
and not exists (
select * 
from movie_cast c3
where c3.person = ap.p2 and not exists (
select * 
from movie_cast c4
where c4.person = ap.p1 and 
c4.movie = c3.movie));

-- esempio semplificato per verificare il funzionamento della query
-- sul db imdb il tempo di esecuzione sarebbe eccessivo a causa della numerosità dei record di crew
Si consideri la seguente istanza di crew(person, movie):

crew
person | movie
==============
  A        1
  B        1
  C        1
  A        2
  D        2

create table crew (
person varchar,
movie varchar,
p_role varchar,
primary key(person, movie)
);

insert into crew values ('a','1','actor');
insert into crew values ('b','1','actor');
insert into crew values ('c','1','actor');
insert into crew values ('a','2','actor');
insert into crew values ('d','2','actor');



