# Esercitazione 4 - Funzioni Polinomiali e Curve di Bézier

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Venerdì 24 Ottobre 2025, ore 13:00-16:00 (Aula G1)

---

## Argomento

Entriamo nel cuore della grafica vettoriale: **valutazione di polinomi** e costruzione di **curve di Bézier**.

**Concetti chiave:**

- **Valutazione polinomiale** — confronto tra metodi:
  - Forma canonica (dalla definizione)
  - Metodo di Horner/Ruffini (efficiente e stabile)
  - Base di Bernstein (fondamentale per Bézier)
- **Algoritmo di de Casteljau** — valutazione ricorsiva, geometricamente intuitiva e numericamente stabile
- **Curve di Bézier** — curve parametriche definite da punti di controllo
- **Suddivisione** — spezzare una curva di Bézier in due parti

**Perché è importante:**  
Le curve di Bézier sono ovunque: font, loghi, grafica vettoriale (SVG, PDF), CAD, animazioni. L'algoritmo di de Casteljau è elegante e robusto — lo useremo spesso.

---

## Materiale di Riferimento

| Tipo   | File                    | Descrizione                         |
| ------ | ----------------------- | ----------------------------------- |
| Testo  | `mnc2526_es4.pdf`       | Consegne degli esercizi             |
| Script | `mnc2526_es4.zip`       | Codice MATLAB di partenza           |
| Slide  | `LAB4_poly_curve2d.pdf` | Guida su polinomi e curve di Bézier |

---

## Tips

- De Casteljau non è solo un algoritmo: è anche una costruzione geometrica. Prova a disegnarla a mano!
- I punti di controllo "attraggono" la curva ma (tranne il primo e l'ultimo) non ci passano sopra
- Una curva di Bézier di grado n ha n+1 punti di controllo
