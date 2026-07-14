| **Comando**     | **Effetto**              |
| --------------- | ------------------------ |
| \l              | Elenca i DB attivi       |
| \dt             | Elenca le tabelle        |
| \d nome_tabella | Struttura di una tabella |
| \q Esci         |                          |

- Esegui la query corrente ->  Ctrl+Enter
- Esegui tutto il file ->  Alt+X
- Formatta il codice SQL ->  Ctrl+Shift+F
- Commento/decommento -> riga Ctrl+/

---

I personaggi sono caratterizzati da un nome e una professione tra le quali sappiamo esistere "politico" e "militare". Nel caso dei politici sappiamo che essi possono afferire a un partito. Nei caso dei militari sappiamo che possiedono un grado (e.g., tenente, colonnello, generale). Non necessariamente, politici e militari sono professioni disgiunte: un politico può essere un militare e viceversa. I personaggi possono avere uno o più titoli (e.g., Re di Francia, Cavaliere del Lavoro). I personaggi possono partecipare agli eventi con un ruolo (e.g., condottiero, ambasciatore). I personaggi prendono parte a eventi storici. Gli eventi hanno una descrizione e avvengono in una data o in un intervallo di date. Gli eventi possono essere fra loro collegati da relazioni di causa/effetto. La parte tratteggiata mostra una rappresentazione alternativa dell'attributo multivalore titolo_onorifico Gli eventi possono essere associati a una sequenza di fasi ciascuna fornita di un testo narrativo.

Ogni fase avviene in un preciso
luogo che può essere una città
o una nazione. Una città
appartiene a una nazione per
uno specifico intervallo di
tempo. E' possibile che una città
appartenga a nazioni diverse in
intervalli di tempo distinti.

Un evento può avere uno o più
documenti associati (e.g., trattati,
dipinti, immagini).

Dei personaggi possiamo
memorizzare le città in cui sono
nati/deceduti e la relativa data.