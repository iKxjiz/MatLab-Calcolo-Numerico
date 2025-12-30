# Esercitazione 8 - Sistemi Lineari e Fattorizzazione LU

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Venerdì 5 Dicembre 2025, ore 13:00-16:00 e Giovedì 11 Dicembre 2025, ore 14:00-17:00 (Aula G1/E2)

---

## Argomento

Risolvere **Ax = b**: il problema più classico dell'algebra lineare numerica. Come farlo in modo efficiente e stabile.

**Concetti chiave:**

- **Metodi diretti** — risolvono il sistema in un numero finito di operazioni:
  - Sostituzione in avanti/indietro (per matrici triangolari)
  - Eliminazione di Gauss
- **Fattorizzazione LU** — scomporre A = LU per risolvere più sistemi con la stessa matrice
- **Pivoting** — scambiare righe per evitare divisioni per numeri piccoli (stabilità!)
- **Fattorizzazione PA = LU** — versione con permutazioni
- **Costo computazionale** — O(n³) per la fattorizzazione, O(n²) per ogni sistema risolto
- **Applicazioni al disegno** — riproduzione di forme vettoriali 2D

**Perché è importante:**  
I sistemi lineari sono ovunque: interpolazione, minimi quadrati, equazioni differenziali, machine learning, grafica 3D... La fattorizzazione LU è il cavallo di battaglia dei metodi diretti.

---

## Materiale di Riferimento

| Tipo   | File                             | Descrizione                      |
| ------ | -------------------------------- | -------------------------------- |
| Testo  | `mnc2526_es8.pdf`                | Consegne degli esercizi          |
| Script | `mnc2526_es8.zip`                | Codice MATLAB di partenza        |
| Slide  | `LAB8_disegno_vettoriale_2d.pdf` | Guida su LU e disegno vettoriale |

---

## Tips

- In MATLAB, `A\b` risolve il sistema scegliendo automaticamente il metodo migliore
- `[L,U,P] = lu(A)` restituisce la fattorizzazione con pivoting
- Mai invertire una matrice per risolvere un sistema! (`inv(A)*b` è lento e instabile — usa `A\b`)
- Una volta calcolata LU, risolvere nuovi sistemi con la stessa A costa "quasi niente"
