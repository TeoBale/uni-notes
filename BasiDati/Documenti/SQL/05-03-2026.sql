-- appunti lezione del 20260330
-------------------------------

-- query ricorsive
-- https://www.postgresql.org/docs/current/queries-with.html#QUERIES-WITH-RECURSIVE
-- esempio introduttivo che restituisce i primi 100 numeri
with recursive t(n) as (
    select 1
    union
    select n+1
    from t
    where n < 100
)
select n from t;

with recursive t(n) as (
    select 1
    union
    select n+1
    from t
    where n < 100
)
select n from t;

-- vediamo ora un caso realistico dove l'uso della ricorsione permette il reperimento di dati da strutture gerarchiche

-- introduciamo un'anagrafica dei generi con la tabella genre_taxonomy
-- un genere può avere un solo padre (o nessuno se è un genere "radice") e più figli: è una struttura ad albero
create table imdb.genre_taxonomy (
genre_name varchar primary key,
genre_parent varchar 
);

-- il vincolo di chiave esterna deve essere definito dopo la creazione della tabella genre_taxonomy poichè tabella referente e riferita coincidono e la tabella riferita deve esistere quando definisco il vincolo
-- genre_taxonomy.genre_parent -> genre_taxonomy.genre_name
alter table imdb.genre_taxonomy add constraint "fk_genre_tax" foreign key (genre_parent) references genre_taxonomy(genre_name);

-- ecco un possibile sviluppo della tassonomia dei generi: 
--Thriller
---Noir
----Poliziesco
-----Spionaggio
-----Cronaca nera
---Splatter

-- le seguenti istruzioni di inserimento permettono di popolare la tabella genre_taxonomy
INSERT INTO imdb.genre_taxonomy VALUES ('Thriller', NULL);
INSERT INTO imdb.genre_taxonomy VALUES ('Noir', 'Thriller');
INSERT INTO imdb.genre_taxonomy VALUES ('Poliziesco', 'Noir');
INSERT INTO imdb.genre_taxonomy VALUES ('Spionaggio', 'Poliziesco');
INSERT INTO imdb.genre_taxonomy VALUES ('Cronaca nera', 'Poliziesco');
INSERT INTO imdb.genre_taxonomy VALUES ('Splatter', 'Thriller');

-- trovare tutti i generi da cui discende "Cronaca nera"
-- fermare il risultato ai generi distanti al massimo due passi dal punto iniziale
with recursive get_parent(genre1, genre2, distance) as (
select *, 1
from imdb.genre_taxonomy 
where genre_name = 'Cronaca nera'
union 
select gp.genre1, gt.genre_parent, distance + 1
from get_parent gp inner join imdb.genre_taxonomy gt on gp.genre2 = gt.genre_name 
where gt.genre_parent is not null 
-- condizione aggiuntiva se vogliamo fermarci a passo 2: 
-- and distance < 2 
)
select *
from get_parent;

-- genre1 			| genre2			| distanza 
-- ==============================================
-- Cronaca nera	  	Poliziesco		    1
-- Cronaca nera	 	Noir				2
-- Cronaca nera 		Thriller			3 

-- trovare tutti i discendenti (figli) di Thriller
with recursive get_children(genre1, genre2, distance) as (
select genre_parent, genre_name, 1
from imdb.genre_taxonomy 
where genre_parent = 'Thriller'
union 
select gp.genre1, gt.genre_name, distance + 1
from get_children gp inner join imdb.genre_taxonomy gt on gp.genre2 = gt.genre_parent 
)
select *
from get_children;

-- vediamo un altro esempio con l'esplorazione di una struttura dati che memorizza le adiacenze di un grafo
-- trovare i film simili a Inception a distanza minore di 3
select * from imdb.movie where official_title = 'Inception'
-- codice pellicola 1375666
select * from imdb.sim where movie1 = '1375666' and score > 0.4 and movie1 <> movie2; 

-- restituire le pellicole simili a Inception a distanza 2 massimo con similarità minima 0.4
-- escludere i record dove movie1 = movie2 (un film è simile a sè stesso)
-- la condizione: ss.movie1<>si.movie2 impedisce di restituire il movie di partenza tra i risultati quando il grafo delle similarità contiene loop
with recursive search_sim(movie1, movie2, distance, score) as (
select movie1, movie2, 1, score 
from imdb.sim inner join imdb.movie on sim.movie1 = movie.id 
where official_title = 'Inception' and score > 0.4 and movie1 <> movie2
union 
select ss.movie1, si.movie2, distance + 1, ss.score*si.score
from search_sim ss inner join imdb.sim si on ss.movie2 = si.movie1
where si.score > 0.4 and si.movie1 <> si.movie2 and ss.movie1<>si.movie2 and distance < 2
)
select m1.id, m1.official_title, m2.id, m2.official_title, ss.distance, ss.score 
from search_sim ss inner join imdb.movie m1 on ss.movie1 = m1.id inner join imdb.movie m2 on ss.movie2 = m2.id  
order by score desc, m1.id;

-- sim 
-- ============================
-- movie1  | movie2  
-- 1375666   1677720  
-- 1375666   3829984  
-- 3829984   1677720
-- 1677720   1375666

-- risultato della ricorsione 
-- ============================
-- movie1  | movie2  | distance
-- 1375666   1677720    1
-- 1375666   3829984    1
-- 1375666   1677720    2 

-- il film 1677720 viene restituito due volte a distanza diversa 



-- basi di dati attive
-- le basi di dati possono eseguire un'azione automatica a fronte di eventi monitorati 
-- paradigma evento-condizione-azione (trigger)
-- possibili eventi: insert, delete, update su una specifica tabella


-- esempio:
-- voglio fare in modo che un film non abbia mai più di 2 registi e ne abbia sempre almeno 1 
-- devo monitorare gli inserimenti su crew: l'inserimento è consentito solo se il numero di registi della pellicola è inferiore a 2 prima del nuovo inserimento
insert into imdb.crew(movie, person, p_role) values ('039390', '484849', 'director');

create trigger <nometrigger> <evento> on <nometabella> for each <granularità> execute proceduere <nomefunzione>;
-- evento: insert, delete, update con clausola before (il trigger viene invocato prima che l'evento sia avvenuto) o after (il trigger viene invocato dopo che l'evento è avvenuto)
-- granularity: row (la funzione viene eseguita per ogni riga interessata dall'evento), statement (la funzione viene eseguita una sola volta)
-- funzione è l'azione eseguita per verificare eventuali condizioni ed eseguire specifiche azioni

create trigger check_registi before insert on imdb.crew for each row execute check_numero_registi();
-- prima dell'inserimento su crew, per ogni riga inserita, eseguo la funzione check_numero_registi
-- la funzione deve verificare i registri presenti in crew. l'istruzione insert viene correttamente eseguita se non risultano registi o ne risulta solo 1 per il film oggetto dell'inserimento 
-- se il film ha già due registi, il nuovo inserimento viene annullato dalla funzione (raise error)

-- altro esempio
-- un trigger può essere usato per tenere aggiornata una tabella con statistiche 
-- per ogni film, restituire il numero di persone coinvolte in ogni ruolo 
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

-- il risultato della precedente query può essere materializzato per scopi di efficienza 
-- quando la query è particolarmente costosa (numerosi record nella tabella crew) ed invocata frequentemente, può essere conveniente creare una tabella per materializzare il risultato dei conteggi:
create table imdb.movie_statistics (
    id varchar,
    role varchar,
    counter integer 
    primary(id, role)
)

-- popolo la tabella movie_statistics con la query cte
insert into imdb.movie_statistics (
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
);

-- nel momento in cui ci sono inserimenti/aggiornamenti/cancellazioni su crew, è necessario aggiornare i contatori di movie_statistics
-- nel caso di insert dovremo incrementare il contatore del film interessato sul reltivo ruolo interessato
insert into imdb.crew(movie, person, p_role) values ('2345235', '3252522', 'actor');

-- nel caso di delete dovremo azzerare i contatori del film specificato
-- questa operazione può interessare numerosi record di crew (tutti quelli legati al movie specificato)
-- il trigger può scattare "for each row" ed eseguire un decremento dei contatori per ogni singolo record eliminato
-- in questo caso è più conveniente usare la granularità "for each statement" che farà un'unica invocazione della funzione specificata dal trigger ed eseguirà un azzeramento di tutti i contatori in movie_statistics associati alla pellicola cancellata
delete from imdb.crew where movie = '235253';

-- la seguente eliminazione è possibile se la chiave esterna crew.movie ha politica cascade. In questo caso, l'eliminazione dei record di crew innesca il trigger che deve azzerare i contatori in movie_statistics per il film specificato
delete from imdb.movie where id = '235253';


-- viste materializzate
-- https://www.postgresql.org/docs/current/rules-materializedviews.html
create materialized view imdb.movie_statistics as (
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
)

REFRESH MATERIALIZED VIEW imdb.movie_statistics;

-- viste aggiornabili
-- https://www.postgresql.org/docs/current/sql-createview.html
-- si veda la sezione "updatable views" nella pagina del manuale per le condizioni necessarie affinchè una vista sia aggiornabile
-- la seguente è una vista aggiornabile
create view imdb.movie_thrillers as (
    select * from imdb.genre where genre = 'Thriller'
) with check option; 

-- il seguente inserimento su movie_thrillers è possibile
insert into imdb.movie_thrillers(movie, genre) values ('849353', 'Thriller');

-- il seguente inserimento non è possibile se la vista è definita con CHECK OPTION (come nel caso sopra)
-- il record inserito non è visibile nella vista e la check option impedisce l'inserimento di questi record (si veda l'opzione check option nella pagina del manuale sulle viste)
insert into imdb.movie_thrillers(movie, genre) values ('849353', 'Drama');
