# Esercitazione 3 - Numeri Finiti e Trasformazioni Geometriche

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Venerdì 17 Ottobre 2025, ore 13:00-16:00 (Aula G1)

---

## Argomento

Dalla teoria alla pratica: sperimentiamo con i **numeri finiti** visti a lezione e impariamo a **trasformare oggetti geometrici** nel piano.

**Concetti chiave:**

- **Numeri finiti e floating point** — vedere "dal vivo" gli effetti della rappresentazione limitata (arrotondamenti, errori, limiti di precisione)
- **Trasformazioni geometriche 2D:**
  - **Traslazione** — spostare un oggetto
  - **Rotazione** — ruotare attorno a un punto
  - **Scalatura** — ingrandire/rimpicciolire
  - **Composizione** — concatenare più trasformazioni
- **Coordinate omogenee** — rappresentazione matriciale unificata per tutte le trasformazioni

**Perché è importante:**  
Capire i limiti dei numeri finiti è fondamentale per evitare errori numerici nei calcoli. Le trasformazioni geometriche sono alla base della grafica 2D e ci serviranno per manipolare le curve di Bézier.

---

## Materiale di Riferimento

| Tipo   | File                       | Descrizione                             |
| ------ | -------------------------- | --------------------------------------- |
| Testo  | `mnc2526_es3.pdf`          | Consegne degli esercizi                 |
| Script | `mnc2526_es3.zip`          | Codice MATLAB di partenza               |
| Slide  | `LAB3_finiti_trasgeom.pdf` | Guida su numeri finiti e trasformazioni |

---

## Tips

- Prova a sommare `1` e `1e-16` in MATLAB: il risultato ti sorprenderà (spoiler: cancellazione numerica!)
- Le matrici di trasformazione 2D in coordinate omogenee sono 3×3
- L'ordine delle trasformazioni conta: ruotare e poi traslare ≠ traslare e poi ruotare
