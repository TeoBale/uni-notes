-- esercizio A: derivare lo schema ER del db scopus4ds (reverse engineering)

-- scopus relational schema
publication(id, title*, citedby*, issn*, pubdate*, pubname*, pubtype*) PK(id)

affiliation(afid, afname*, afcity*, afcountry*) PK(afid)

author(authid, authname*, authsurname*, given_name*) PK(authid)

pub_author(pubid, authid, afid) PK(pubid, authid, afid)
FK: pub_author.pubid -> publication.id
FK: pub_author.authid -> author.authid
FK: pub_author.afid -> affiliation.afid

abstract(pubid, language, content*) PK(pubid, language)
FK: abstract.pubid -> publication.id

keyword(pubid, keyword, language) PK(pubid, keyword)
FK: keyword.pubid -> publication.id

expertise(field, parent_field*) PK(field)
FK: expertise.parent_field -> expertise.field 

author_expertise(authid, expertise) PK(authid, expertise)
FK: author_expertise.authid -> author.authid
FK: author_expertise.expertise -> expertise.field 


-- ESERCIZI DI ALGEBRA e SQL
-- trovare le keyword usate in tutte le pubblicazioni della rivista 'computer comminication'

-- divisione
R(AB)
S(B)

R÷S(A)

keyword(pubid, keyword, language)
publication(id, pubname, pubtype)


A = π_(pubid, keyword) KEYWORD 

B = 𝛒(pubid<-id) (π_(id) ( 𝛔_(pubname = 'computer comminication' ∧ pubtype = 'journal') PUBLICATION ))

risultato = A÷B 

-- trovare le keyword che non sono mai usate su pubblicazioni di tipo articolo 


-- trovare le pubblicazioni che hanno sia 'social networks' sia 'community detection' come keyword



-- ESERCIZI DI SQL
-- devo restituire le keyword k per le quali non esiste una pubblicazione p per la quale non esiste l'associazione fra k e p
select keyword
from publications.keyword k1
where not exists (
    select * 
    from publications.publication p 
    where pubname = 'computer comminication' and pubtype = 'journal' and not exists (
        select *
        from publications.keyword k2  
        where k2.pubid = p.id and k2.keyword = k1.keyword 
    )
)

-- altra soluzione 
with comm_pubs as (
select * 
    from publications.publication  
    where pubname = 'computer comminication' and pubtype = 'journal'
), keyword_list as (
    select distinct keyword 
    from publications.keyword 
)
select keyword
from keyword_list k1
where not exists (
    select *
    from comm_pubs p
     not exists (
        select *
        from publications.keyword k2  
        where k2.pubid = p.id and k2.keyword = k1.keyword 
    )
)

-- trovare gli autori che partecipano a una pubblicazione con due affiliazioni diverse
-- ricordare che è possibile per un autore partecipare alla stessa pubblicazione più volte con la stessa affiliazione
-- trovare due record nei quali: i) l'autore è lo stesso, ii) la pubblicazione è la stessa, iii) cambia l'affiliazione
pub_author(authid, pubid, afid, id)

-- soluzione con group by 
select authid, pubid 
from publications.pub_author 
group by authid, pubid 
having count(distinct afid) > 1

-- soluzione self-join 
-- questa soluzione non considera i casi di afid = null
select distinct pa1.authid 
from publications.pub_author pa1, publications.pub_author pa2
where pa1.authid = pa2.authid and pa1.pubid = pa2.pubid and pa1.afid < pa2.afid

-- consideriamo la query precedente ma vogliamo includere anche i casi in cui l'autore partecipa alla pubblicazione più volte anche con affiliazione nulla
< soluzione precedente >
UNION 
select distinct pa1.authid 
from publications.pub_author pa1, publications.pub_author pa2
where 

-- trovare le pubblicazioni X con citazioni superiori alla media considerando le pubblicazioni della rivista su cui è pubblicata X
publication(id, pubname, citedby)

pubblicazione P1 pubblicata su R1 ed è citata 50
pubblicazione P2 pubblicata su R1 ed è citata 20
le pubblicazioni su R1 hanno in media 40 citazioni 
la pubblicazione P2 è nel risultato

-- soluzione corretta, ma inefficiente
-- explain analyze
select id, title, citedby 
from publications.publication p1 
where  citedby > (
    select avg(citedby)
    from publications.publication p2
    where p1.pubname = p2.pubname 
) 

-- soluzione senza correlazione (più efficiente)
-- explain analyze
with pubname_citations as (
    -- per ogni pubname calcolo avg
    select pubname, avg(citedby) as avg_citations
    from publications.publication
    group by pubname 
)
select id, title
from publications.publication p inner join pubname_citations pc on p.pubname = pc.pubname 
where p.citedby > pc.avg_citations;

-- trovare le expertise da cui discende 'conceptual design';
expertise(field, parent_field)

-- computer science
--- data management
---- relational data model
----- conceptual design

expertise
field                   | parent_field
=======================================
computer science        | null
data management         | computer science
relational data model   | data management 
conceptual design       | relational data model

with recursive get_hierarchy(field, parent, distance) as (
    select field, parent_field, 1
    from expertise
    where field = 'conceptual design'
    UNION 
    select gh.field, ex.parent_field, distance + 1
    from get_hierarchy gh INNER JOIN expertise ex ON gh.parent = ex.field 
)
select parent as superclasse, distance
from get_hierarchy
where parent is not null;

-- trovare i co-autori di montanelli stefano (autori di pubblicazioni in cui montanelli stefano è un autore). Usare la condizione authname = 'montanelli s.' per trovare le pubblicazioni

-- trovare le keyword usate solo sulla rivista 'information and computer security'

-- Trovare la pubblicazione con il maggior numero di keyword associate

-- Trovare la keyword usata il maggior numero di volte

-- trovare gli autori che non hanno mai pubblicato con persone appartenenti alla medesima affiliazione