# Esercitazione 7 - Equazioni Non Lineari e Intersezione di Curve

**Corso:** Metodi Numerici per il Calcolo (A.A. 2025/26)  
**Data:** Giovedì 27 Novembre 2025, ore 15:00-18:00 (Aula G1)

---

## Argomento

Trovare gli **zeri di funzioni**: quando f(x) = 0 non si risolve a mano. Applicazione grafica: **intersezione tra curve**.

**Concetti chiave:**

- **Metodo di bisezione** — lento ma sicuro, dimezza l'intervallo ad ogni passo
- **Metodo di Newton** — velocissimo (convergenza quadratica) ma richiede f'(x) e un buon punto di partenza
- **Metodo delle secanti** — come Newton, ma approssima la derivata
- **Metodo del punto fisso** — riformulare f(x)=0 come x=g(x) e iterare
- **Criteri di arresto** — quando fermarsi? (tolleranza, residuo, max iterazioni)
- **Intersezione di curve 2D** — ricondursi a trovare zeri di funzioni

**Perché è importante:**  
Moltissimi problemi si riducono a "trova x tale che...". I metodi iterativi sono lo strumento standard. L'intersezione di curve è fondamentale in grafica, CAD, e collision detection.

---

## Materiale di Riferimento

| Tipo   | File                        | Descrizione                  |
| ------ | --------------------------- | ---------------------------- |
| Testo  | `mnc2526_es7.pdf`           | Consegne degli esercizi      |
| Script | `mnc2526_es7.zip`           | Codice MATLAB di partenza    |
| Slide  | `LAB7_intersez_curve2d.pdf` | Guida su zeri e intersezioni |

---

## Tips

- Newton può divergere o ciclare se parti dal punto sbagliato — usa bisezione prima per "avvicinarti"
- Per le secanti servono due punti iniziali, non uno
- Intersecare due curve di Bézier? Si può usare la suddivisione ricorsiva + bounding box per escludere zone senza intersezioni
