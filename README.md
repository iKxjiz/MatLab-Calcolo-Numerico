# MATLAB Calcolo Numerico

Repository degli esercizi di laboratorio per il corso di Metodi Numerici Computazionali (MNC).

## Struttura

```
├── Laboratorio1/        # Operazioni matriciali, vettori, fattoriale
├── Laboratorio2/        # Funzioni, plotting, vettorizzazione, cardioidi
├── Laboratorio3/        # Trasformazioni geometriche 2D, conversioni binarie
├── Laboratorio4/        # Curve di Bezier, De Casteljau, valutazione polinomiale
├── Laboratorio5/        # Interpolazione (Lagrange, Chebyshev, fenomeno di Runge)
├── Laboratorio6/        # Integrazione numerica (trapezi compositi, Simpson)
├── Laboratorio7/        # Metodi avanzati, ricerca binaria
├── Laboratorio8/        # Sistemi lineari (fattorizzazione LU/QR, matrici di Hilbert)
├── Extra/               # Esercizi pre-esame, figure, curve di Bezier
├── Pre-Esame/           # Materiale preparazione esami
├── anmglib_5.0/         # Libreria geometria computazionale completa
├── short_anmglib_5.0/   # Versione ridotta libreria
└── VecchiaLib/          # Libreria legacy
```

## Libreria anmglib_5.0

Libreria MATLAB per geometria computazionale e modellazione parametrica:

- **Curve 2D/3D**: Bezier, NURBS, Spline, piecewise polynomial
- **Superfici**: Bezier, NURBS, ruled, revolved, extruded
- **Algoritmi**: De Casteljau, De Boor, Lane-Riesenfeld
- **Trasformazioni**: rotazione, traslazione, scaling, simmetria
- **Utilità**: intersezioni, offset, calcolo lunghezze/aree, parsing SVG