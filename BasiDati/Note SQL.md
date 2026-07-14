```sql

trim(attributo) -- elimina ' ' da inizio e fine
to_char(data_nascita) -- casting a varchar
lower(attributo) -- Lower Case
char_length(attributo) -- # di caratteri
initcap(nome) -- inizia con maiuscola

current_date -- date corrente
now() -- timestamp corrente

extract(year from data_nascita) -- extraact solo per titpi date
extract(year from data_nascita)::text -- casting 

data_nastica between data1 and data2 -- check in between
year in (year1, year2, year3) -- check in set

AGE(data) -- calcola l’intervallo tra la data e oggi
DATE_PART('year', ...) -- estrae gli anni da qualsisasi tipo

-- Per aggiungere x anni ad un Date
data_inizio + (anni_da_aggiungere || ' YEAR')::INTERVAL;

-- Tempo in un dato intervallo
IF CURRENT_TIME BETWEEN '08:00:00' AND '20:00:00' THEN

title like ‘murder’ -- case sensitive
title ilike ‘%muRdEr%’ -- non è case sensitive 
_ -- un carattere
% -- qualunque stringa

order by x asc -- ordine ascendente
order by x desc -- ordine discendente

union -- niente duplicati
union all -- duplicati
intersect -- Intersezione
except -- Sottrazione

---------------------------- ES --------------------------------
select distinct movie
from material inner join text on material.id=text.material 
union
select distinct movie
from material inner join multimedia on material.id=multimedia.material
order by movie;

select distinct movie
from material inner join text on material.id=text.material 
union all
select distinct movie
from material inner join multimedia on material.id=multimedia.material
order by movie;
```

altro file altra avventura

```sql
distinct -- valori distinti per un insieme di attributi

min(attributo) -- minimo tra i valori dell'attributo
max(attributo) -- massimo tra i valori dell'attributo
sum(attributo) -- somma tra i valori dell'attributo
avg(attributo) -- metria tra i valori dell'attributo
count(*) -- conta tutti i record
count(attributo) -- conta record che hanno attributo
count(distinct attributo) -- conta record distinti

order by -- criterio di ordinamento
group by -- esegue solo per un attributo
having

where movie_number = (select max_number from max_movies);

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

-- la seguente NON è una soluzione corretta: non funziona quando ho più persone che hanno lo stesso valore massimo di film interpretati
select person, count(*) as movie_number
from imdb.crew c
where p_role = 'actor'
group by person
order by 2 desc
limit 1


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

primary key(person, movie)
```


```sql
create trigger <nometrigger> <evento> on <nometabella> for each <granularità> execute proceduere <nomefunzione>
```

Cose che posso grantare: _(GRANT)_

- **`SELECT`**: Permette di leggere i dati (fare le query).
    
- **`INSERT`**: Permette di inserire nuove righe.
    
- **`UPDATE`**: Permette di modificare i dati esistenti.
    
- **`DELETE`**: Permette di cancellare i dati.
    
- **`TRUNCATE`**: Permette di svuotare interamente una tabella velocemente.
    
- **`REFERENCES`**: Permette di creare vincoli di chiave esterna (Foreign Key) che puntano a quella tabella.
    
- **`TRIGGER`**: Permette di creare trigger sulla tabella.
    
- **`ALL PRIVILEGES`**: Assegna _tutti_ i permessi disponibili su quell'oggetto in un colpo solo.

```sql

COMMIT -- applicare modifiche di una transazione
ROLEBACK -- scartare le modifiche di una transazione in corso


BEGIN TRANSACTION; 
    UPDATE imdb.country_area set sqkm = sqkm - 500 
    WHERE country = 'ITA';
    UPDATE imdb.country_area set sqkm = sqkm - 500 
    WHERE country = 'FRA';
    insert into imdb.country_area values ('FRI', 1000.0);
COMMIT;



-- tabelle person e crew di imdb
-- supponiamo che la base di dati debba soddisfare il vincolo: ogni persona partecipa ad almeno un film (trigger)
-- la transazione deferred  comporta la verifica dei vincoli alla fine della transazione
begin transaction deferred;
	insert into imdb.person(id, birth_date, given_name) 
	values ('43848', '1975-04-02', 'Pedro Pascal');

	insert into imdb.crew(movie, person, p_role) 
	values ('897293', '43848', 'producer');
commit;
```

perform -> esegue ma non restituisce select

## Trigger

All’interno della funzione trigger, PostgreSQL mette a disposizione variabili predefinite:

- **NEW**: Record contenente i dati per INSERT o i nuovi dati per UPDATE. (In DELETE è NULL).
	
- **OLD**: Record contenente i dati originali prima di UPDATE o DELETE. (In INSERT è NULL).
	
- **TG_OP**: Variabile testuale che indica l’operazione (INSERT, UPDATE, DELETE, TRUNCATE).
	
- **TG_TABLE_NAME**: Nome della tabella che ha scatenato il trigger.

- TG_ARGV\[0]::integer;
