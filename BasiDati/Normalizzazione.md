
obiettivi:
- ridurre i valori nulli
- ridurre la ridondanza dei dati 

principi di buona progettazione:
- un singolo oggetto (istanza) deve corrispondere a una e una sola tupla
- una classe di oggetti con le medesime proprietà deve corrispondere a un'unica relazione/tabella
- le relazioni devono legarsi fra di loro evitando di generare corrispondenze scorrette in fase di join 
- utilizzare attributi con valori atomici

Se una dipendenza è costituita da tutti gli attributi della relazione, nessuna decomposizione la può conservare _(non si può avere la conservazione delle dipendenze)_???

NOOOO big stronzata del prof incapace dupa
Come si verifica la condizione di lossless join:
	Data una relazione $R(X)$ e $X_1, X_2$ i sottoinsiemi di $X$ tali che $X_1 \cup X_2 = X$ e $X_1 \cap X_2 = X_0$ la relazione $R$ si decompone senza perdita in $R_1(X_1) \land R_2(X_2)$ se $X_0$ è chiave in $X_1 \lor X_2$.

## Dipendenza Funzionale

Una **dipendenza funzionale** $X → Y$ tra due sottoinsiemi di attributi $X$ e $Y$ di una relazione R stabilisce un vincolo sui _record_ che possono formare uno stato di relazione $r$ di $R$
$$
X, Y \subset \text{Attributi di } R
$$
Presi $t_1$ e $t_2$ come due record di $r$
$$
\text{se } t_1[x] = t_2[x] \text{ si ha } t_1[y] = t_2[y] \implies  t_1[x] = t_2[x] \rightarrow t_1[y] = t_2[y] 
$$
Se $X$ è una chiave di $R$, allora $X \rightarrow Y$ vale per ogni subset $Y$ di attributi di $R$

## Regole di inferenza

1. Regola riflessiva: $X ⊇ Y ⊨ X → Y$

2. Regola di arricchimento: ${X → Y} ⊨ XZ → YZ$

3. Regola transitiva: ${X→Y, Y →Z} ⊨ X → Z$

4. Regola di decomposizione: ${X → YZ} ⊨ X → Y, X → Z$

5. Regola di unione: ${X→Y, X→Z} ⊨ X→YZ$

6. Regola pseudo-transitiva: ${X→Y, WY → Z} ⊨ WX → Z$

### Individuazione dipendenze funzionali

**Chiusura** di $F$ ovvero $F^+$ è un insieme di dipendenze funzionali individuate dal progettista unito all'insieme delle dipendenze funzionali inferite da quelle del progettista in base alle regole di inferenza

---
## Normalizzazione di Relazioni

>**Forme Normali**
>Proprietà delle **relazioni** che sono definite sulle dipendenze funzionali associate

Spesso se una relazione non fosse compatibile con una forma normale la si può **Decomporre** in relazioni più piccole che rispettino la forma normale desiderata.

Durante la decomposizione è importante garantire le seguenti proprietà:
1. **Join senza perdita**
	Ricostruendo una relazione decomposta non devono essere generati record aggiuntivi
2. **Conservazione delle dipendenze**
	Ogni dipendenza deve essere rispettata nello schema normalizzato

---

# Forme Normali

## NF BCNF
Una relazione $R$ è in BCNF se $\forall \text{ dipendenza funzionale, non banale, di } R, X \rightarrow A$
$X$ è una superchiave di $R$

Per raggiungere la BCNF è necessario decomporre $R$ in modo tale per ogni la chiave di ciascuna relazione si il componente di sinistra di ogni diversa dipendenza di $R$.

Non è sempre raggiungibile

## 3 FN
Una relazione $R$ è in BCNF se $\forall \text{ dipendenza funzionale, non banale, di } R, X \rightarrow A$
$X$ è una superchiave di $R$ oppure $A \in$ almeno $1$ chiave _(superchiave minimale)_ di $R$.

O $A$ è determinato da una **Superchiave** 
oppure $A$ appartiene ad una **Superchiave minimale** _($A$ è attributo primo)_

Per ottenere 3 NF è necessario decomporre $R$ in modo che esista una diversa relazione per ogni dipendenza. Mantenere una relazione che contenga la chiave della relazione di partenza

è dimostrato che sia sempre raggiungibile

## 2 NF
- Le relazione che hanno tutte le chiavi composte da un solo attributo ricadono nella 2 NF.

- ~~Relazioni che hanno chiave composta~~ 
  ~~_(Superchiave minimale composta da più di un attributo)_~~

### Dipendenza funzionale completa

- Una dipendenza funzionale $X \rightarrow Y$ si dice **completa** se la rimozione di un qualsiasi attributo $A$ da $X$ comporta che la dipendenza non sia più valida.

- Una dipendenza funzionale $X \rightarrow Y$ si dice **parziale** se esiste un attributo $A, A \in X$ tale che $(X - A) \rightarrow Y$.

### Attributo non primo

Un attributo $A$ dello schema $R$ è **primo** se e solo se fa parte di almeno una chiave _(Superchiave minimale)_ di $R$.
Altrimenti $A$ viene detto non primo, quando non fa parte di nessuna chiave di $R$.

### Definizione

Una relazione $R$ è in 2FN se ogni attributo $A, A\text{ Non Primo}$ dipende _funzionalmente in modo completo_ dalla chiave primaria di $R$.

Per ottenere la 2NF è necessario, data una chiave primaria composta $X$, decomporre $R$ realizzando una relazione che conservi $X$ _(la chiave primaria)_ e, per ogni dipendenza parziale $(X -A ) \rightarrow Y$ , una distinta relazione con schema $(x - A) \cup Y$ e chiave primaria $(X -A )$.

Le relazione con chiave composta da un sono attributo sono sempre in 2NF.

## 1 NF

Uno schema di relazione $R(X)$ è in 1NF se ogni attributo $A, A \in X$ è un attributo semplice _(Atomico)_.

Vengono quindi esclusi attributi **multivalore** e attributi **strutturati**.
