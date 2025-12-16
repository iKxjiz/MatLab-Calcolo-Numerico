# Esercitazione 6 - Integrazione Numerica, Lunghezza e Area di Curve

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Venerdì 14 Novembre 2025 e Venerdì 21 Novembre 2025, ore 13:00-16:00 (Aula G1)

---

## Argomento

Calcolare integrali quando non si può (o non conviene) farlo analiticamente. Applicazione pratica: **lunghezza** e **area** di curve nel disegno vettoriale.

**Concetti chiave:**

- **Formule di quadratura** — approssimare ∫f(x)dx con somme pesate:
  - Formula dei Trapezi
  - Formula di Simpson
- **Formule composte** — suddividere l'intervallo per maggiore precisione
- **Estrapolazione di Richardson** — migliorare la stima "gratis"
- **Applicazioni alle curve 2D:**
  - **Lunghezza di una curva** — integrale di √(x'² + y'²)
  - **Area racchiusa** — formula di Gauss-Green

**Perché è importante:**  
Gli integrali sono ovunque nei calcoli reali, e raramente hanno soluzione analitica. Sapere stimarli numericamente (e con che errore!) è essenziale. Lunghezza e area sono proprietà fondamentali nel disegno e nella modellazione.

---

## Materiale di Riferimento

| Tipo    | File                         | Descrizione                                   |
| ------- | ---------------------------- | --------------------------------------------- |
| Testo   | `mnc2526_es6.pdf`            | Consegne degli esercizi                       |
| Script  | `mnc2526_es6.zip`            | Codice MATLAB di partenza                     |
| Slide   | `LAB6_area_lung_curve2d.pdf` | Guida su integrazione e proprietà geometriche |
| Toolbox | `anmglib_5.0.zip`            | Versione aggiornata della libreria            |

---

## Tips

- Simpson è esatto per polinomi fino a grado 3 (non solo 2!) — ha un "grado di precisione bonus"
- Per curve di Bézier, la derivata è facile da calcolare: è un'altra curva di Bézier di grado n-1
- Raddoppiare i sottointervalli nelle formule composte → errore che cala come h² (trapezi) o h⁴ (Simpson)
