====================
Lezione del 20260521
====================

-- esempio di violazione dell'integrità a seguito di operazioni atomiche 

create table imdb.country_area(
    country char(3) primary key references imdb.country(iso3),
    sqkm double precision 
);

insert into imdb.country_area values ('ITA', 301340.0);
insert into imdb.country_area values ('FRA', 643801.0);

-- voglio costituire un nuovo paese attribuendo 1000 km2 presi da ITA e FRA sottraendo 500km2 a ciascuno dei due paesi:
-- senza transazione, le operazioni di update vengono eseguite, ma l'insert finale solleva un'eccezione (violazione della chiave esterna su country): ho perso 1000km2
-- l'uso di una transazione risolve il problema
BEGIN TRANSACTION; 
    UPDATE imdb.country_area set sqkm = sqkm - 500 WHERE country = 'ITA';
    UPDATE imdb.country_area set sqkm = sqkm - 500 WHERE country = 'FRA';
    insert into imdb.country_area values ('FRI', 1000.0);
COMMIT;

-- ogni istruzione SQL viene eseguita come una transazione
-- supponiamo che un rating non possa avere score negativo
-- la seguente istruzione potrebbe andare a buon fine per alcuni record, ma innescare un errore su altri record
-- il fatto che il comando sia una transazione implica che un eventuale errore su un singolo record produce un rollback su tutte le modifiche
update imdb.rating set score = score - 1 where source = 'imdb';

rating 
score
4.5   --> diventa 3.5
0.73  --> diventa negativo: errore!

-- ipotizziamo che la funzione change_rating coverta a zero un eventuale valore negativo su score
-- il seguente trigger sanifica gli score negativi prima che vengano sollevati errori dovuti alla violazione del vincolo
create trigger test_rating before update on imdb.rating for each row execute procedure change_rating();

-- esempio di lost update 
U1: X:= read(X) + 100
U2: X:= read(X) + 200
U1: write(X) -- +100
U2: write(X) -- +200

-- esempio di dirty read
U1: X:= read(X) + 100
U1: write(X) -- +100
U2: X:= read(X) + 200
U2: write(X) -- +300
U1: abort

-- esempio incorrect summary
U2: sum : = 0
U1: X := read(X) + 100
U1: write(X)
U2: sum := sum + read(X)
U2: sum := sum + read(Y)
U1: Y := read(Y) + 200
U1: write(Y)

-- tabelle person e crew di imdb
-- supponiamo che la base di dati debba soddisfare il vincolo: ogni persona partecipa ad almeno un film (trigger)
-- la transazione deferred  comporta la verifica dei vincoli alla fine della transazione
begin transaction deferred;
insert into imdb.person(id, birth_date, given_name) values ('43848', '1975-04-02', 'Pedro Pascal');

insert into imdb.crew(movie, person, p_role) values ('897293', '43848', 'producer');
commit;