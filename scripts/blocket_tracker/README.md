# Blocket Car Tracker

Automatisk integration mellan Blocket bilannonser och bilfinansieringskalkylatorn.

När du surfar på Blocket och tittar på bilannonser hämtas pris och registreringsnummer automatiskt och fylls i kalkylatorn.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              DATAFLÖDE                                      │
└─────────────────────────────────────────────────────────────────────────────┘

  ┌───────────────┐                      ┌───────────────┐
  │   FIREFOX     │                      │   FIREFOX     │
  │  ┌─────────┐  │                      │  ┌─────────┐  │
  │  │ Blocket-│  │                      │  │Kalkylator│  │
  │  │  annons │  │                      │  │  :8765/ │  │
  │  └────┬────┘  │                      │  └────┬────┘  │
  └───────┼───────┘                      └───────┼───────┘
          │                                      │
          │ 1. Content script                    │ 4. Poll var
          │    extraherar pris                   │    3:e sekund
          │    och reg.nr                        │
          ▼                                      │
  ┌───────────────┐                              │
  │  Background   │                              │
  │    script     │                              │
  └───────┬───────┘                              │
          │                                      │
          │ 2. POST /car                         │ 3. GET /car
          │                                      │
          ▼                                      ▼
  ┌─────────────────────────────────────────────────────┐
  │                                                     │
  │              Python Server (localhost:8765)         │
  │                                                     │
  │   Lagrar senaste bil: { pris, regNummer, url }     │
  │                                                     │
  └─────────────────────────────────────────────────────┘
```

## Installation

### 1. Installera Firefox-extensionen

1. Öppna Firefox och gå till `about:debugging`
2. Klicka på "This Firefox" i vänstermenyn
3. Klicka "Load Temporary Add-on..."
4. Navigera till denna mapp och välj `manifest.json`

Extensionen är nu aktiv och kommer extrahera data från Blocket-annonser.

> **OBS:** Temporära tillägg försvinner när Firefox startas om. För permanent installation behöver extensionen signeras via Mozilla.

### 2. Starta servern

```bash
cd ~/dotfiles/scripts/blocket_tracker
python server.py
```

Servern startar på `http://localhost:8765` och visar inkommande bildata i terminalen.

### 3. Öppna kalkylatorn

Gå till http://localhost:8765/ i webbläsaren.

## Användning

1. Ha servern igång i en terminal
2. Ha kalkylatorn öppen i en flik
3. Surfa till en bilannons på Blocket (t.ex. `blocket.se/mobility/item/12345`)
4. Priset fylls automatiskt i kalkylatorn inom 3 sekunder

### Statusindikatorn

Kalkylatorn visar en statusruta högst upp:

| Färg | Betydelse |
|------|-----------|
| Gul | Väntar på data eller server ej startad |
| Grön | Bil hämtad - visar reg.nr, pris och länk till annonsen |

## Filer

| Fil | Beskrivning |
|-----|-------------|
| `manifest.json` | Firefox extension manifest |
| `content.js` | Content script som körs på Blocket-sidor |
| `server.py` | Lokal HTTP-server som tar emot och serverar bildata |
| `icon.svg` | Extension-ikon |

## API

Servern exponerar följande endpoints:

| Endpoint | Metod | Beskrivning |
|----------|-------|-------------|
| `/` | GET | Serverar bilfinansieringskalkylatorn |
| `/car` | GET | Hämtar senaste bildata (JSON) |
| `/car` | POST | Ta emot bildata från extensionen |
| `/clear` | POST | Rensa sparad bildata |

### Exempel på bildata

```json
{
  "regNummer": "ABC123",
  "pris": 199000,
  "prisTkr": 199,
  "titel": "Volvo V60 2019",
  "url": "https://www.blocket.se/mobility/item/12345",
  "timestamp": 1702486800000
}
```

## Felsökning

**Extensionen hittar inte priset:**
Blocket ändrar ibland sin HTML-struktur. Öppna webbläsarens utvecklarverktyg (F12) och kolla konsolen för felmeddelanden från `[Blocket Tracker]`.

**Kalkylatorn visar "Server ej ansluten":**
Kontrollera att `server.py` körs i en terminal.

**CORS-fel:**
Öppna kalkylatorn via servern (`http://localhost:8765/`) istället för som lokal fil.
