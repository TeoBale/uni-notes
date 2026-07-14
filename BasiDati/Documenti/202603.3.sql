-- appunti lezione del 20260316
-------------------------------

-- SQL (Structure Query Language) - SELECT
-- DDL (Data Definition Language) - CREATE/ALTER/DROP
-- DML (Data Manipulation Language) - INSERT/UPDATE/DELETE

-- comandi di interrogazione
select *
from imdb.movie 

-- AS nella clausola SELECT è l'operatore di ridenominazione
select id as "movie id", year, official_title as title   
from imdb.movie;

-- restituire i film prodotti nel 2010 e mostrare id, title e year nel risultato
select id, official_title, year
from imdb.movie 
where year = '2010';

-- restituire i film prodotti in anni diversi da 2010 e mostrare id, title e year nel risultato
select id, official_title, year
from imdb.movie 
where year <> '2010';

-- restituire i dati dell'attore Leonardo DiCaprio
SELECT *
from imdb.person 
where given_name = 'Leonardo DiCaprio';

-- i confronti sono case sensitive
SELECT *
from imdb.person 
where given_name = 'leonardo diCaprio';

-- postgres offre numerose funzioni built-in per i confronti con diversi tipi di dato
-- https://www.postgresql.org/docs/9.1/functions-string.html
-- https://www.postgresql.org/docs/current/functions-datetime.html

-- la funzione lower/upper converte a lowercase/uppercase il valore di una stringa
-- char_length restituisce la lunghezza in caratteri di una stringa
SELECT *, lower(given_name) as "lower name", char_length(given_name)
from imdb.person 
where lower(given_name) = 'leonardo dicaprio';

-- restituire i dati delle persone nate il giorno 11 novembre 1974
select *
from imdb.person 
where birth_date = '1974-11-11';

-- restituire le persone nate nel 1974
select *
from imdb.person 
where birth_date >= '1974-01-01' and birth_date <= '1974-12-31';

-- soluzione con between (operatore SQL)
select *
from imdb.person 
where birth_date between '1974-01-01' and '1974-12-31';

-- soluzione con uso di funzioni Postgres
-- extract permette di estrarre una parte da un valore di tipo date
-- to_char restituisce un dato come char specificando il formato
-- :: è l'operatore di casting da un tipo di dato a un'altro (float to text in questo caso)
select id, given_name, birth_date, to_char(birth_date, 'DD/MM/YYYY') as it_birth_date, extract(year from birth_date)::text as birth_year
from imdb.person 
where extract(year from birth_date)::text = '1974';

-- restituire i film con durata compresa tra 1 e 2 ore
select *
from imdb.movie
where length >= 60 and length <= 120

select *
from imdb.movie
where length between 60 and 120

-- restituire le pellicole con anno più recente del 2010 e durata compresa fra 1 e due ore estremi esclusi 
select *
from imdb.movie
where length > 60 and length < 120 and year > '2010'

-- restituire le pellicole con anno più recente del 2010 oppure durata compresa fra 1 e due ore estremi esclusi 
-- tenere presente che gli operatori booleani sono applicati da sinistra a destra
-- l'uso di parentesi permette di personalizzare la precedenza delle operazioni 
select *
from imdb.movie
where year > '2010' or (length > 60 and length < 120)

select *
from imdb.movie
where length > 60 and length < 120 or year > '2010'

-- trovare le pellicole prodotte negli anni 2011, 2013, 2015
select *
from imdb.movie
where year = '2011' or year = '2013' or year = '2015'

select *
from imdb.movie
where year IN ('2011', '2013', '2015');

-- trovare le persone delle quali non si conosce la data di decesso
select *
from imdb.person 
where death_date is null 

-- trovare le persone decedute 
select *
from imdb.person 
where death_date is not null 

select * from imdb.movie
-- 1031 film nella tabella movie
select * from imdb.movie where year = '2010'
-- 19 film del 2010
select * from imdb.movie where year <> '2010'
select * from imdb.movie where not (year = '2010')
-- 987 film che non sono del 2010
select * from imdb.movie where year is null
-- 25 film per i quali non conosciamo il valore di year 

-- trovare i film che riguardano assassini (murder)
-- intendiamo film che hanno murder nel titolo
-- like prevedere % come wildcard: qualunque stringa
-- like prevedere _ come wildcard: qualunque stringa di 1 carattere
select *
from imdb.movie 
where lower(official_title) like '%murder%'

-- trovare i film che hanno murder all'inizio del campo 
select *
from imdb.movie 
where lower(official_title) like 'murder%'

-- trovare i film che hanno murder alla fine 
select *
from imdb.movie 
where lower(official_title) like '%murder'

-- film che hanno "murder" nella trama 
-- ilike - like insensitive (operatore postgres non disponibile in altri dbms)
select *
from imdb.movie 
where plot ilike '%murder%'

-- come posso escludere i casi di declinazione di murder (murdering, murders)
select *
from imdb.movie 
where plot ilike '% murder %'

-- modifico il titolo del film 0058329
-- inserisco una "anomalia" nel titolo, cioè uno spazio bianco all'inizio della stringa
update imdb.movie set official_title = ' Marnie' where id = '0058329'

-- trovare i dati del film Marnie
-- funzione trim per eliminare spazi bianchi all'inizio e alla fine di un campo 
select * 
from imdb.movie 
where trim(official_title) = 'Marnie'

-- trovare le persone nate nel 1980 ordinando per nome crescente 
-- ordinamento del risultato
-- ASC ordinamento predefinito
-- ASC/DESC modalità crescente o decrescente 
select *
from imdb.person 
where extract(year from birth_date)::text = '1980'
order by given_name desc

-- ordinare rispetto alla data di nascita (ASC) e poi al nome (DESC)
select *
from imdb.person 
where extract(year from birth_date)::text = '1980'
order by birth_date [asc], given_name desc

-- operazioni di join 
-- trovare il titolo delle pellicole di genere Thriller 
select *
from imdb.genre 
where genre = 'Thriller'

-- questa è l'operazione di prodotto cartesiano fra genre e movie 
select *
from imdb.genre, imdb.movie 

-- cardinalità del prodotto cartesiano:
-- 2483 record in imdb.genre
-- 1031 record in imdb.movie
-- 2483x1031 record nel prodotto cartesiano 

-- questo è il join dove seleziono i record corrispondenti nel prodotto cartesiano 
select *
from imdb.genre, imdb.movie 
where genre.movie = movie.id 

-- sintassi alternativa
select *
from imdb.genre inner join imdb.movie on genre.movie = movie.id 

-- risultato della query
-- trovare il titolo delle pellicole di genere Thriller 
select movie.id, movie.official_title
from imdb.genre, imdb.movie 
where genre.movie = movie.id and genre = 'Thriller'

select movie.id, official_title
from imdb.genre inner join imdb.movie on genre.movie = movie.id 
where genre = 'Thriller'

-- ordina il risultato in base al titolo 
select movie.id, official_title
from imdb.genre inner join imdb.movie on genre.movie = movie.id 
where genre = 'Thriller'
order by official_title 

-- trovare il nome degli attori che recitano in inception
select p.id, p.given_name, "character", m.official_title, p_role  
from imdb.person p, imdb.crew c, imdb.movie m
where p.id=c.person and c.movie=m.id and m.official_title ilike 'inception' and p_role = 'actor'
order by character

select p.id, p.given_name, "character", m.official_title, p_role  
from imdb.person p inner join imdb.crew c on p.id=c.person inner join imdb.movie m on c.movie=m.id 
where m.official_title ilike 'inception' and p_role = 'actor'
order by character

-- trovare i film che sono Comedy e Thriller 
-- questa soluzione è errata: restituisce sempre insieme vuoto
select *
from imdb.genre g 
where genre = 'Thriller' and genre = 'Comedy'

-- questa soluzione è errata: ottengo film che sono di un solo genere
select *
from imdb.genre g 
where genre = 'Thriller' or genre = 'Comedy'
order by movie

-- la soluzione utilizza self-join
select *
from genre gt, genre gc 
where gt.genre = 'Thriller' and gc.genre = 'Comedy' and gt.movie=gc.movie 

select gt.movie 
from genre gt inner join genre gc on gt.movie=gc.movie
where gt.genre = 'Thriller' and gc.genre = 'Comedy'

-- altra soluzione con subquery o query innestata o query nidificata
select g.movie 
from genre g 
where g.genre = 'Thriller' and g.movie in
(select  g.movie
from genre g 
where g.genre = 'Comedy');

-- altra soluzione con intersect 
select g.movie 
from genre g 
where g.genre = 'Thriller' 
intersect
select g.movie 
from genre g 
where g.genre = 'Comedy'

-- soluzione in cui restituisco anche il titolo nel risultato
select movie.id, movie.official_title 
from genre gt inner join genre gc on gt.movie=gc.movie inner join imdb.movie on gc.movie=movie.id 
where gt.genre = 'Thriller' and gc.genre = 'Comedy'

-- altra soluzione con subquery o query innestata o query nidificata
select g.movie, movie.id, official_title 
from genre g inner join imdb.movie on g.movie=movie.id 
where g.genre = 'Thriller' and g.movie in
(select  g.movie
from genre g 
where g.genre = 'Comedy');

-- altra soluzione con intersect 
select g.movie, official_title 
from genre g inner join imdb.movie on g.movie=movie.id 
where g.genre = 'Thriller' 
intersect
select g.movie, official_title 
from genre g inner join imdb.movie on g.movie=movie.id 
where g.genre = 'Comedy'

-- la seguente è equivalente come soluzione?
-- no: due pellicole distinte possono avere lo stesso titolo e finirebbero erroneamente nel risultato
select official_title 
from genre g inner join imdb.movie on g.movie=movie.id 
where g.genre = 'Thriller' 
intersect
select official_title 
from genre g inner join imdb.movie on g.movie=movie.id 
where g.genre = 'Comedy'


movie
=====
id  | official_title
=====================
001		M1
002		M1

genre
======
movie | genre
=============
001		Thriller
002     Comedy 


-- Appunti lezione del 20260318
-------------------------------

-- selezionare il titolo delle pellicole prodotte negli Stati Uniti
select id, official_title 
from imdb.movie inner join imdb.produced on movie = id 
where country = 'USA';

-- selezionare i paesi nei quali sono state distribuite le pellicole del 2010 
-- posso eliminare i duplicati nel risultato? uso la clausola distinct in select 
select distinct country, name 
from imdb.movie inner join imdb.released on movie = id inner join imdb.country on country = iso3
where year = '2010'
order by country; 

-- aggiungo il titolo della pellicola al risultato 
select distinct country, name, official_title, title  
from imdb.movie inner join imdb.released on movie = id inner join imdb.country on country = iso3
where year = '2010'
order by country; 

-- selezionare le pellicole per le quali non è noto il titolo di distribuzione in Italia


-- selezionare gli attori che hanno recitato nel film Inception


-- selezionare gli attori che hanno recitato in pellicole del 2010


-- selezionare le persone che sono decedute in un paese diverso da quello di nascita
select *
from imdb.location l_birth, imdb.location l_death
where l_birth.d_role = 'B' and l_death.d_role = 'D' and l_birth.person = l_death.person and l_birth.country <> l_death.country; 

select *
from imdb.location l_birth inner join imdb.location l_death on l_birth.person = l_death.person
where l_birth.d_role = 'B' and l_death.d_role = 'D' and  l_birth.country <> l_death.country; 

-- nella query sopra, cosa succederebbe se fosse possibile avere NULL sull'attributo location.country?
-- esempio: individuo nato in CAN e deceduto [NULL]
-- questi record non apparterrebbero al risultato: i valori NULL sono sempre ignorati nelle operazioni di confronto 

-- mostrare il nome degli individui selezionati nella query precedente 
select id, given_name, l_birth.country, l_death.country
from imdb.location l_birth inner join imdb.location l_death on l_birth.person = l_death.person inner join imdb.person on person.id = l_birth.person   
where l_birth.d_role = 'B' and l_death.d_role = 'D' and  l_birth.country <> l_death.country; 

-- common table expressions (CTE)
-- https://www.postgresql.org/docs/current/queries-with.html
with country_different as (
select l_birth.person, l_birth.country as country_birth, l_death.country as country_death  
from imdb.location l_birth inner join imdb.location l_death on l_birth.person = l_death.person
where l_birth.d_role = 'B' and l_death.d_role = 'D' and  l_birth.country <> l_death.country)
select given_name, country_different.*
from imdb.person inner join country_different on person.id = country_different.person 

-- alternativa con cte in altra versione 
with p_birth as (
select person, country 
from imdb.location 
where d_role = 'B'),
p_death as (
select person, country 
from imdb.location 
where d_role = 'D'),
country_different as (
select p_birth.person, p_birth.country as birth_country,  p_death.country as death_country
from p_birth inner join p_death on p_birth.person = p_death.person 
where p_birth.country <> p_death.country)
select given_name, country_different.*
from imdb.person inner join country_different on person.id = country_different.person ; 

-- in una base di dati relazionale è possibile definire  viste (view)
-- una vista è una query la cui definizione è memorizzata nel db e può essere usata in altre query 
-- una vista non materializza il risultato della query, memorizza solo la definizione 
-- creare una vista che memorizza i generi di ciascun movie 
create view imdb.movie_genre as (
select *
from imdb.movie inner join imdb.genre on movie = id);

-- la vista può essere ora usata in altre query 
-- la vista è utile per personalizzare i permessi di accesso sui dati delle relazioni nel db
-- trovare il titolo dei film di genre Thriller
-- la vista non materializza il risultato della query
select id, official_title
from imdb.movie_genre
where genre = 'Thriller';

-- selezionare i film che non hanno materiali associati
-- sono i film che compaiono in movie e non compaiono come chiave esterna in material
select id 
from imdb.movie 
except 
select distinct movie
from imdb.material 

-- postgreSQL mette a disposizione il comando EXPLAIN per stimare il tempo di esecuzione di uno statement SQL 
-- https://www.postgresql.org/docs/current/sql-explain.html
explain analyze 
select movie
from imdb.material 

explain analyze 
select distinct movie
from imdb.material 

explain analyze 
select id 
from imdb.movie 
except 
select movie
from imdb.material

explain analyze 
select id 
from imdb.movie 
except 
select distinct movie
from imdb.material

-- soluzione alternativa 
-- explain analyze
select id 
from imdb.movie 
where id not in  
(select distinct movie
from imdb.material)

-- soluzione alternativa 
-- join esterno - left join
-- A left join B on A.c = B.d contiene il risultato del join interno (inner) al quale si aggiungono le tuple spurie della relazione A (cioè la relazione a sinistra del join)
-- explain analyze  
select *
from imdb.movie left outer join imdb.material on movie.id = material.movie 
where material.movie is null
-- clausola WHERE ugualmente valida:
-- where material.id is null; 

-- selezionare i paesi nei quali non sono prodotti film


-- selezionare i film per i quali esistono materiali multimediali di tipo immagine o materiali testuali di qualche genere
-- union filtra i duplicati (cioè i record che appartengono al risultato di entrambe le query in union)
-- union all restituisce anche i duplicati (quindi avremo due record per una pellicola che appartiene al risultato di entrambe le query in union)
select distinct movie 
from imdb.text inner join imdb.material on material.id = text.material 
union  
select movie 
from imdb.multimedia inner join imdb.material on material.id = multimedia.material 
where type ='image'
order by movie


-- selezionare i film per i quali esistono materiali multimediali di tipo immagine e materiali testuali di qualche genere
-- explain analyze
select distinct movie 
from imdb.text inner join imdb.material on material.id = text.material 
intersect  
select movie 
from imdb.multimedia inner join imdb.material on material.id = multimedia.material 
where type ='image'
order by movie

-- soluzione alternativa con cte e join 
-- explain analyze
with movie_image as (
select movie 
from imdb.multimedia inner join imdb.material on material.id = multimedia.material 
where type ='image'),
movie_text as (
select distinct movie 
from imdb.text inner join imdb.material on material.id = text.material)
select mi.movie 
from movie_image mi inner join movie_text mt on mi.movie = mt.movie; 


-- selezionare i film per i quali esistono materiali multimediali di tipo immagine o materiali testuali, ma non entrambi (or esclusivo)


-- selezionare i paesi nei quali non sono prodotti film
select  iso3
from imdb.country 
except 
select country  
from imdb.produced 

-- resetituire il nome dei paesi nei quali non sono prodotti film
select  iso3, name 
from imdb.country   
except 
select country, name  
from imdb.produced inner join imdb.country on country = iso3 

-- alternativa
with no_productions as (
select  iso3
from imdb.country 
except 
select country  
from imdb.produced
)
select country.iso3, name 
from imdb.country inner join no_productions on country.iso3 = no_productions.iso3

-- versione con natural join 
with no_productions as (
select  iso3
from imdb.country 
except 
select country  
from imdb.produced
)
select country.iso3, name 
from imdb.country natural join no_productions 

-- alternativa (subquery)
select  iso3, name 
from imdb.country 
where iso3 not in (
select country  
from imdb.produced);

-- alternativa (outer join)
select * 
from imdb.country c left join imdb.produced p on c.iso3 = p.country 
where movie is null; 

-- oltre al join esterno a sinistra esiste il join esterno a destra (right outer join)
-- A right join B on A.c = B.d contiene il risultato del join interno (inner) al quale si aggiungono le tuple spurie della relazione B (cioè la relazione a destra del join)
select * 
from imdb.produced p right join imdb.country c on c.iso3 = p.country 
where movie is null;

-- un'ulteriore versione di join esterno è il full outer join 
-- A full join B on A.c = B.d contiene il risultato del join interno (inner) al quale si aggiungono le tuple spurie della relazione A (cioè la relazione a sinistra del join) e le tuple spurie della relazione B (cioè la relazione a destra del join)

-- ulteriore versione 
-- restituire i country c per i quali non esiste un record di produced con movie = c.iso3
-- query correlata: si dice correlata una query nidificata dove la subquery contiene riferimenti a relazioni nella main query 
explain analyze
select *
from imdb.country c
where not exists (
select * 
from imdb.produced p
where p.country = c.iso3);


-- selezionare le pellicole prodotte solo in Italia
-- cerco film prodotti in italia e non prodotti altrove 

produced  
========
movie | country
===============
001		ITA
002		ITA * 
001		USA 

-- questa soluzione non offre il risultato desiderato
-- i filtri su country vengono fatti dopo il join quindi la clausola left non trova tuple spurie e la condizione is null non trova alcun risultato
select * 
from imdb.produced m_ita left join imdb.produced n_ita on m_ita.movie = n_ita.movie
where m_ita.country = 'ITA' and n_ita.country <> 'ITA' and n_ita.movie is null;

-- questa soluzione è corretta: filtrando n_ita.country <> 'ITA' nella clausola di join permette di includere la tupla 002-ITA come spuria
select * 
from imdb.produced m_ita left join imdb.produced n_ita on m_ita.movie = n_ita.movie and n_ita.country <> 'ITA'
where m_ita.country = 'ITA' and n_ita.movie is null;

-- prodotto cartesiano di produced m_ita e produced n_ita
movie | country | movie | country
=================================
001		ITA		  001		ITA 
001		ITA		  002		ITA
001		ITA		  001		USA 
002		ITA		  001		ITA
002		ITA		  002		ITA
002		ITA		  001		USA 
001		USA		  001		ITA
001		USA		  002		ITA
001		USA		  001		USA 

-- record nel join interno (inner) considerando la clausola from:
-- imdb.produced m_ita inner join imdb.produced n_ita on m_ita.movie = n_ita.movie and n_ita.country <> 'ITA' 
movie | country | movie | country
=================================
001		ITA		  001		USA 
001		USA		  001		USA

-- record nel join esterno a sinistra (left) considerando la clausola from:
-- imdb.produced m_ita left join imdb.produced n_ita on m_ita.movie = n_ita.movie and n_ita.country <> 'ITA' 
-- al risultato di inner si aggiunge l'unico record spurio di produced:
movie | country | movie | country
=================================
001		ITA		  001		USA 
001		USA		  001		USA
002		ITA 

-- soluzione con cte
-- i filtri su m_ita e n_ita sono fatti prima del left join 
with m_ita as (
select *
from imdb.produced 
where country = 'ITA'
), n_ita as (
select *
from imdb.produced 
where country <> 'ITA')
select *
from m_ita left join n_ita on m_ita.movie = n_ita.movie
where n_ita.movie is null; 

m_ita
=====
movie | country 
================
001		ITA
002		ITA

n_ita
movie | country 
================
001		USA

m_ita left join n_ita on m_ita.movie = n_ita.movie
movie | country | movie | country
=================================
001		ITA			001		USA
002		ITA 

-- soluzione con except
select movie
from imdb.produced 
where country = 'ITA'
except
select movie
from imdb.produced 
where country <> 'ITA'


-- restituire il titolo dei film con durata superiore alla durata di Inception


-- Trovare i film thriller con la migliore valutazione

-- questa soluzione non è soddisfacente
-- limit è una clausola che limita il risultato al numero di record specificato. Utile quando si deve paginare il risultato di una query (usandola insieme alla clausola OFFSET)
-- non è soddisfacente perchè  qualora ci fossero più film con la medesima valutazione massima solo il primo sarebbe restituito e gli altri sarebbero esclusi
with thrillers as (
select *
from imdb.genre g 
where genre = 'Thriller'
)
select r.*
from imdb.rating r inner join thrillers t on t.movie = r.movie
order by score/scale desc
limit 1

-- la valutazione massima è quella che non risulta inferiore ad altre valutazioni
-- uso join per trovare le valutazioni che non sono massime (sono inferiori ad almeno un'altra)
-- uso except per trovare la valutazione massima
with thrillers as (
select *
from imdb.genre g 
where genre = 'Thriller'
), thrillers_rating as (
select rating.*, score/scale as evaluation
from imdb.rating natural join thrillers),
thrillers_non_max as (
select distinct tr2.*
from thrillers_rating tr1 inner join thrillers_rating tr2 on tr1.evaluation > tr2.evaluation)
select *
from thrillers_rating
except 
select *
from thrillers_non_max;

-- soluzione con left join 
-- questa soluzione funziona solo se il movie con valutazione massima ha un'unica valutazione
with thrillers as (
select *
from imdb.genre g 
where genre = 'Thriller'
), thrillers_rating as (
select rating.*, score/scale as evaluation
from imdb.rating natural join thrillers),
thrillers_non_max as (
select distinct tr2.*
from thrillers_rating tr1 inner join thrillers_rating tr2 on tr1.evaluation > tr2.evaluation)
select tr.*
from thrillers_rating tr left join thrillers_non_max tn on tr.movie = tn.movie 
where tn.movie is null;

-- soluzione con exists
with thrillers as (
select *
from imdb.genre g 
where genre = 'Thriller'
), thrillers_rating as (
select rating.*, score/scale as evaluation
from imdb.rating natural join thrillers)
SELECT tr1.*
FROM thrillers_rating tr1
WHERE NOT EXISTS (
    SELECT *
    FROM thrillers_rating tr2 
    WHERE tr2.evaluation > tr1.evaluation
);


-- restituire le coppie di attori che hanno recitato insieme in almeno due film diversi


-- selezionare le persone che hanno recitato in film nei quali erano registi


-- trovare le coppie di pellicole che non hanno generi in comune


-- Trovare le persone che hanno partecipato ad almeno due film distinti usciti nello stesso anno