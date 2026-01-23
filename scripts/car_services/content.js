// Blocket Car Tracker - Content Script
// Extraherar registreringsnummer och pris från Blocket bilannonser

(function() {
    'use strict';

    function extractCarData() {
        let regNummer = null;
        let pris = null;
        let titel = null;
        let farg = null;

        // Försök hitta registreringsnummer
        // Leta specifikt efter "Reg" label följt av värdet
        const allText = document.body.innerText;

        // Metod 1: Leta efter "Registreringsnummer" eller "Reg.nr" följt av värdet
        const regLabelMatch = allText.match(/(?:Registreringsnummer|Reg\.?\s?nr\.?|Regnr)[:\s]*([A-Z]{3}\s?[0-9]{2}[0-9A-Z])/i);
        if (regLabelMatch) {
            regNummer = regLabelMatch[1].toUpperCase().replace(/\s/g, '');
        }

        // Metod 2: Leta i specifika element om metod 1 inte hittade något
        if (!regNummer) {
            // Sök i tabellceller och definitionslistor
            const cells = document.querySelectorAll('td, dd, span, div');
            for (const cell of cells) {
                const prevText = cell.previousElementSibling?.innerText || '';
                if (/reg/i.test(prevText)) {
                    const match = cell.innerText.match(/([A-Z]{3}\s?[0-9]{2}[0-9A-Z])/i);
                    if (match) {
                        regNummer = match[1].toUpperCase().replace(/\s/g, '');
                        break;
                    }
                }
            }
        }

        // Försök hitta pris - leta efter element med prisinfo
        // Blocket har ofta pris i en prominent position
        const prisSelectors = [
            '[data-testid="price"]',
            '[class*="Price"]',
            '[class*="price"]',
            'h2[class*="Price"]',
            'span[class*="Price"]',
            'div[class*="Price"]'
        ];

        for (const selector of prisSelectors) {
            const el = document.querySelector(selector);
            if (el) {
                const prisText = el.innerText;
                // Matcha pris som "199 000 kr" eller "199000 kr" eller "199 000:-"
                const prisMatch = prisText.match(/([0-9\s]+)\s*(kr|:-)/i);
                if (prisMatch) {
                    pris = parseInt(prisMatch[1].replace(/\s/g, ''), 10);
                    break;
                }
            }
        }

        // Fallback: sök efter pris i hela texten
        if (!pris) {
            // Leta efter mönster som "Pris: 199 000 kr" eller bara "199 000 kr"
            const prisMatches = allText.match(/(?:pris[:\s]*)?([1-9][0-9]{0,2}(?:\s?[0-9]{3})+)\s*(?:kr|:-)/gi);
            if (prisMatches && prisMatches.length > 0) {
                // Ta första matchningen som ser ut som ett bilpris (rimligt intervall)
                for (const match of prisMatches) {
                    const numMatch = match.match(/([0-9\s]+)/);
                    if (numMatch) {
                        const num = parseInt(numMatch[1].replace(/\s/g, ''), 10);
                        // Rimligt bilpris: 10 000 - 2 000 000 kr
                        if (num >= 10000 && num <= 2000000) {
                            pris = num;
                            break;
                        }
                    }
                }
            }
        }

        // Hämta titel/rubrik
        const titleEl = document.querySelector('h1');
        if (titleEl) {
            titel = titleEl.innerText.trim();
        }

        // Försök hitta färg
        // Leta efter "Färg" label följt av värdet
        const fargMatch = allText.match(/(?:Färg|Kulör)[:\s]*([A-Za-zÅÄÖåäö]+)/i);
        if (fargMatch) {
            farg = fargMatch[1].trim();
            // Gör första bokstaven stor
            farg = farg.charAt(0).toUpperCase() + farg.slice(1).toLowerCase();
        }

        return {
            regNummer,
            pris,
            prisTkr: pris ? Math.round(pris / 1000) : null,
            titel,
            farg,
            url: window.location.href,
            timestamp: Date.now()
        };
    }

    function sendToServer(data) {
        // Skicka via background script för att undvika CORS/CSP-problem
        browser.runtime.sendMessage({
            type: 'carData',
            data: data
        }).then(response => {
            if (response && response.success) {
                console.log('[Blocket Tracker] Data skickad:', data);
            } else {
                console.log('[Blocket Tracker] Server svarade inte:', response);
            }
        }).catch(err => {
            console.log('[Blocket Tracker] Kunde inte skicka meddelande:', err.message);
        });
    }

    // Kör extraktion och skicka data (endast om fliken är aktiv)
    function run() {
        if (document.hidden) {
            return; // Skicka inte från bakgrundsflikar
        }

        const data = extractCarData();
        if (data.pris || data.regNummer) {
            sendToServer(data);
        }
    }

    // Kör när fliken blir synlig
    document.addEventListener('visibilitychange', () => {
        if (!document.hidden) {
            setTimeout(run, 500);
        }
    });

    // Kör direkt om fliken är aktiv
    if (!document.hidden) {
        run();
        setTimeout(run, 2000);
    }

    // Observera DOM-ändringar för SPA-navigation
    let lastUrl = window.location.href;
    const observer = new MutationObserver(() => {
        if (window.location.href !== lastUrl) {
            lastUrl = window.location.href;
            if (!document.hidden) {
                setTimeout(run, 1000);
            }
        }
    });
    observer.observe(document.body, { childList: true, subtree: true });
})();
