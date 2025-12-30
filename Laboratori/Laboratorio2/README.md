# Esercitazione 2 - Script, Function e Grafici

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Venerdì 10 Ottobre 2025, ore 13:00-16:00 (Aula G1)

---

## Argomento

Approfondiamo MATLAB: dalle semplici sequenze di comandi alla creazione di **funzioni riutilizzabili** e alla **visualizzazione grafica**.

**Concetti chiave:**

- **Function** — blocchi di codice autonomi con input/output, salvati in file `.m` separati
- **Grafici di funzioni** — `plot`, `fplot` e personalizzazione (titoli, assi, colori)
- **Curve in forma parametrica** — disegnare curve 2D dove x(t) e y(t) sono funzioni di un parametro
- **I/O da file** — caricare e salvare dati con `load` e `save`
- **Toolbox `anmglib_5.0`** — libreria grafica del corso per il disegno vettoriale

**Perché è importante:**  
Le function sono il mattone fondamentale per organizzare il codice. I grafici ci permetteranno di "vedere" i metodi numerici in azione e capire cosa sta succedendo.

---

## Materiale di Riferimento

| Tipo    | File                      | Descrizione                |
| ------- | ------------------------- | -------------------------- |
| Testo   | `mnc2526_es2.pdf`         | Consegne degli esercizi    |
| Script  | `mnc2526_es2.zip`         | Codice MATLAB di partenza  |
| Slide   | `LAB2_matlab_IIparte.pdf` | Guida a function e grafici |
| Toolbox | `anmglib_5.0.zip`         | Libreria per il disegno 2D |

---

## Tips

- Una function deve avere lo **stesso nome** del file che la contiene (es. `myfun.m` → `function y = myfun(x)`)
- Usa `hold on` per sovrapporre più grafici sulla stessa figura
- Il toolbox `anmglib` va aggiunto al path di MATLAB con `addpath('percorso/anmglib_5.0')`
