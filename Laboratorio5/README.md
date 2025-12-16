# Esercitazione 5 - Interpolazione Polinomiale

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Venerdì 7 Novembre 2025, ore 13:00-16:00 (Aula G1)

---

## Argomento

Il problema classico: dati dei punti, trovare una curva che **passi esattamente** per tutti. Esploriamo l'**interpolazione polinomiale** e le sue varianti.

**Concetti chiave:**

- **Interpolazione polinomiale** — trovare il polinomio di grado minimo che passa per n+1 punti
- **Forme dell'interpolante:**
  - Forma di Lagrange (funzioni elementari di Lagrange)
  - Forma di Bernstein (via sistema lineare)
- **Fenomeno di Runge** — perché interpolare con tanti punti equispaziati può essere disastroso
- **Nodi di Chebyshev** — distribuzione intelligente dei punti per evitare oscillazioni
- **Interpolazione a tratti** — spezzare il problema in pezzi più gestibili:
  - Lineare a tratti (C⁰)
  - Cubica a tratti / Hermite (C¹)

**Perché è importante:**  
L'interpolazione è fondamentale per approssimare dati sperimentali, ricostruire funzioni, e disegnare curve che passano per punti assegnati. Capire i suoi limiti (Runge!) evita brutte sorprese.

---

## Materiale di Riferimento

| Tipo   | File                      | Descrizione                              |
| ------ | ------------------------- | ---------------------------------------- |
| Testo  | `mnc2526_es5.pdf`         | Consegne degli esercizi                  |
| Script | `mnc2526_es5.zip`         | Codice MATLAB di partenza                |
| Slide  | `LAB5_curve2d_interp.pdf` | Guida su interpolazione e curve a tratti |

---

## Tips

- Prova a interpolare `1/(1+25x²)` su [-1,1] con 10, 15, 20 punti equispaziati: vedrai Runge in azione
- L'interpolazione a tratti cubica C¹ richiede anche le derivate nei nodi (dati o stimati)
- Più punti ≠ sempre meglio. A volte, meno è più!
