// Blocket Car Tracker - Background Script
// Tar emot data från content script och skickar till servern

const SERVER_URL = 'http://localhost:8765';

browser.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.type === 'carData') {
        fetch(SERVER_URL + '/car', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(message.data)
        })
        .then(response => response.json())
        .then(data => {
            console.log('[Blocket Tracker] Data skickad till server:', data);
            sendResponse({ success: true });
        })
        .catch(err => {
            console.error('[Blocket Tracker] Kunde inte nå server:', err);
            sendResponse({ success: false, error: err.message });
        });

        // Return true to indicate we'll send response asynchronously
        return true;
    }
});
