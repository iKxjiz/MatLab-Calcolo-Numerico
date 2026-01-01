# MATLAB Calcolo Numerico

Repository degli esercizi di laboratorio per il corso di **Metodi Numerici Computazionali (MNC)**.

<table>
  <tr>
     <td><img width="676" height="855" src="https://github.com/iKxjiz/MatLab-Calcolo-Numerico/blob/main/Figure/Immagini/smdppbez_interp_lame_ruotate_rosso_blu.png" /></td>
     <td><img width="676" height="855" src="https://github.com/iKxjiz/MatLab-Calcolo-Numerico/blob/main/Figure/Immagini/smdppbez_interp_elica_rosso_blu.png" /></td>
  </tr>
</table>

Questo repository contiene tutto il materiale necessario per seguire e approfondire gli argomenti del corso: esercizi risolti, script MATLAB commentati, figure generate con curve di Bézier, librerie per la geometria computazionale e materiale didattico di riferimento.

---

## Struttura del Repository

```
├── Laboratorio/            # Raccolta laboratori  
├── Figure/                 # Galleria di figure artistiche con curve di Bézier
├── Extra/                  # Materiale aggiuntivo e simulazioni pre-appello
├── Materiale-Didattico/    # Dispense, guide PDF, appunti delle lezioni
├── anmglib_5.0/            # Libreria completa per geometria computazionale
└── Libreria/               # Utilities e funzioni personalizzate
```
---

> Ho condiviso questi appunti, esercizi e figure gratuitamente. La loro realizzazione ha richiesto numerose ore di studio e lavoro; se li trovassi utili, ti invito a lasciare una stella (⭐) alla repository come forma di supporto e riconoscimento.

---

## Come Utilizzare

1. **Clona la repository**:
   ```bash
   git clone https://github.com/iKxjiz/MatLab-Calcolo-Numerico.git
   cd MatLab-Calcolo-Numerico
   ```

2. **Aggiungi la libreria al path MATLAB**:
   ```matlab
   addpath(genpath('anmglib_5.0'));
   savepath;
   ```

3. **Esegui gli esercizi**:
   - Apri MATLAB nella directory del laboratorio desiderato
   - Esegui gli script `.m` presenti

4. **Genera le figure**:
   ```matlab
   cd Figure
   smdppbez_interp_italy  % Esempio: genera la bandiera italiana
   ```

---

## Note

- Gli script utilizzano la convenzione `s*.m` per gli script eseguibili e `f*.m` o `c*.m` per le funzioni
- Molti esercizi richiedono la libreria `anmglib_5.0` per funzionare correttamente
- Il materiale è aggiornato all'anno accademico 2025/2026

---

## Contributi

Se trovi errori o vuoi migliorare il materiale, sentiti libero di aprire una issue o una pull request.
