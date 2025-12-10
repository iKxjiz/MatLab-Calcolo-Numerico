# 📚 FUNZIONI LIBRERIA `anmglib_5.0` UTILIZZATE NEGLI ESERCIZI
## Lista completa senza duplicati - MNC 2025/2026

> **Scopo**: Identificare le funzioni effettivamente utilizzate per rimuovere quelle inutili dalla libreria.
>
> **Totale funzioni utilizzate**: **37 funzioni uniche**

---

## 📊 ELENCO COMPLETO FUNZIONI (Ordine Alfabetico)

### **A - C**
1. ✅ `axis_plot` - Imposta assi con margine e scala
2. ✅ `bernst_val` - Valuta funzioni base di Bernstein
3. ✅ `bernst_valder` - Valuta base di Bernstein + derivate
4. ✅ `chebyshev2` - Genera punti di Chebyshev di seconda specie
5. ✅ `curv2_bezier_area` - Calcola area di curva di Bézier
6. ✅ `curv2_bezier_interp` - Interpolazione con curva di Bézier singola
7. ✅ `curv2_bezier_load` - Carica curva di Bézier da file
8. ✅ `curv2_bezier_plot` - Disegna curva di Bézier
9. ✅ `curv2_bezier_reverse` - Inverte orientazione curva di Bézier
10. ✅ `curv2_bezier_tan_plot` - Disegna tangenti di curva di Bézier
11. ✅ `curv2_intersect` - Calcola intersezione tra due curve di Bézier
12. ✅ `curv2_mdppbezier_area` - Calcola area curva Bézier multi-grado
13. ✅ `curv2_mdppbezier_join` - Unisce curve di Bézier multi-grado
14. ✅ `curv2_mdppbezier_load` - Carica curva Bézier multi-grado da file
15. ✅ `curv2_mdppbezier_plot` - Disegna curva Bézier multi-grado
16. ✅ `curv2_mdppbezier_reverse` - Inverte orientazione curva multi-grado
17. ✅ `curv2_plot` - Disegna curve da funzione analitica parametrica
18. ✅ `curv2_ppbezier_area` - Calcola area curva Bézier a tratti
19. ✅ `curv2_ppbezier_load` - Carica curva Bézier a tratti da file
20. ✅ `curv2_ppbezier_plot` - Disegna curva Bézier a tratti
21. ✅ `curv2_ppbezier_reverse` - Inverte orientazione curva a tratti
22. ✅ `curv2_ppbezierCC1_interp` - Interpolazione cubica a tratti C^1 Hermite
23. ✅ `curv2_ppbezierCC1_interp_der` - Interpolazione Hermite con derivate

### **D - P**
24. ✅ `decast_val` - Algoritmo De Casteljau per valutazione
25. ✅ `decast_valder` - De Casteljau con derivate
26. ✅ `get_mat_scale` - Matrice di scala
27. ✅ `get_mat_trasl` - Matrice di traslazione
28. ✅ `get_mat2_rot` - Matrice di rotazione 2D
29. ✅ `get_mat2_symm` - Matrice di simmetria 2D
30. ✅ `open_figure` - Apre figura con ID specifico
31. ✅ `point_fill` - Riempie area delimitata da punti
32. ✅ `point_plot` - Disegna punti/poligonali 2D
33. ✅ `point_trans` - Trasforma punti con matrice
34. ✅ `point_trans_plot` - Trasforma e disegna punti
35. ✅ `ppbezier_val` - Valuta curve di Bézier a tratti

### **R - V**
36. ✅ `rectangle_plot` - Disegna rettangolo (bounding box)
37. ✅ `vect2_plot` - Disegna vettori 2D

---

## 📋 FUNZIONI PER CATEGORIA

### 🎨 **Setup e Visualizzazione (4)**
- `open_figure` - Gestione figure
- `axis_plot` - Configurazione assi
- `point_plot` - Plot punti
- `vect2_plot` - Plot vettori

### 📐 **Trasformazioni Geometriche (5)**
- `get_mat_trasl` - Traslazione
- `get_mat_scale` - Scala
- `get_mat2_rot` - Rotazione 2D
- `get_mat2_symm` - Simmetria 2D
- `point_trans` - Trasformazione punti

### 🎯 **Curve di Bézier Singole (6)**
- `curv2_bezier_load` - Caricamento
- `curv2_bezier_plot` - Visualizzazione
- `curv2_bezier_interp` - Interpolazione
- `curv2_bezier_area` - Calcolo area
- `curv2_bezier_reverse` - Inversione
- `curv2_bezier_tan_plot` - Tangenti

### 🔗 **Curve di Bézier a Tratti (5)**
- `curv2_ppbezier_load` - Caricamento
- `curv2_ppbezier_plot` - Visualizzazione
- `curv2_ppbezier_area` - Calcolo area
- `curv2_ppbezier_reverse` - Inversione
- `ppbezier_val` - Valutazione

### 🌈 **Curve di Bézier Multi-Grado (4)**
- `curv2_mdppbezier_load` - Caricamento
- `curv2_mdppbezier_plot` - Visualizzazione
- `curv2_mdppbezier_area` - Calcolo area
- `curv2_mdppbezier_join` - Unione curve
- `curv2_mdppbezier_reverse` - Inversione

### 🔢 **Algoritmi di Valutazione (4)**
- `bernst_val` - Base di Bernstein
- `bernst_valder` - Bernstein + derivate
- `decast_val` - De Casteljau
- `decast_valder` - De Casteljau + derivate

### 🎓 **Interpolazione (3)**
- `curv2_ppbezierCC1_interp` - Hermite C^1
- `curv2_ppbezierCC1_interp_der` - Hermite con derivate
- `curv2_bezier_interp` - Interpolazione Bézier

### 🔧 **Utilità (6)**
- `curv2_plot` - Plot curve parametriche
- `curv2_intersect` - Intersezione curve
- `point_trans_plot` - Trasforma e plota
- `point_fill` - Riempimento aree
- `rectangle_plot` - Bounding box
- `chebyshev2` - Punti di Chebyshev

---

⚠️ ATTENZIONE - FILE SPECIALI
NON rimuovere questi file di supporto:

    add_path.m - Setup path libreria
    help_anmglib.m - Documentazione
    File .db - Dati per esempi
    Directory Parser/ - Potrebbe essere necessaria
    Directory ppbez_code/ - Contiene codice aggiuntivo

