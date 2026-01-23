#!/usr/bin/env python3
"""
Blocket Car Tracker Server
Enkel HTTP-server som tar emot bildata från Firefox-extensionen
och serverar den till bilfinansieringskalkylatorn.
"""

import json
import os
from http.server import HTTPServer, BaseHTTPRequestHandler
from datetime import datetime

# Lagra senaste bildata
current_car = None


class BlocketHandler(BaseHTTPRequestHandler):
    def _send_cors_headers(self):
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
        self.send_header("Access-Control-Allow-Headers", "Content-Type")

    def do_OPTIONS(self):
        self.send_response(200)
        self._send_cors_headers()
        self.end_headers()

    def do_GET(self):
        global current_car

        if self.path == "/car":
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self._send_cors_headers()
            self.end_headers()

            if current_car:
                self.wfile.write(json.dumps(current_car).encode())
            else:
                self.wfile.write(json.dumps({"status": "no_data"}).encode())

        elif self.path == "/":
            # Servera kalkylatorn
            calc_path = os.path.join(
                os.path.dirname(__file__), "..", "bilfinansieringskalkylator.html"
            )
            if os.path.exists(calc_path):
                self.send_response(200)
                self.send_header("Content-Type", "text/html; charset=utf-8")
                self._send_cors_headers()
                self.end_headers()
                with open(calc_path, "rb") as f:
                    self.wfile.write(f.read())
            else:
                self.send_response(404)
                self.end_headers()
                self.wfile.write(b"Calculator not found")

        else:
            self.send_response(404)
            self.end_headers()

    def do_POST(self):
        global current_car

        if self.path == "/car":
            content_length = int(self.headers.get("Content-Length", 0))
            body = self.rfile.read(content_length)

            try:
                data = json.loads(body.decode("utf-8"))
                current_car = data
                current_car["received_at"] = datetime.now().isoformat()

                print(f"\n{'='*50}")
                print(f"NY BIL MOTTAGEN - {datetime.now().strftime('%H:%M:%S')}")
                print(f"{'='*50}")
                if data.get("titel"):
                    print(f"Titel: {data['titel']}")
                if data.get("regNummer"):
                    print(f"Reg.nr: {data['regNummer']}")
                if data.get("pris"):
                    print(f"Pris: {data['pris']:,} kr ({data.get('prisTkr')} tkr)")
                if data.get("farg"):
                    print(f"Färg: {data['farg']}")
                if data.get("url"):
                    print(f"URL: {data['url']}")
                print(f"{'='*50}\n")

                self.send_response(200)
                self.send_header("Content-Type", "application/json")
                self._send_cors_headers()
                self.end_headers()
                self.wfile.write(json.dumps({"status": "ok"}).encode())

            except json.JSONDecodeError:
                self.send_response(400)
                self._send_cors_headers()
                self.end_headers()
                self.wfile.write(b"Invalid JSON")

        elif self.path == "/clear":
            current_car = None
            print("[Server] Bildata rensad")
            self.send_response(200)
            self._send_cors_headers()
            self.end_headers()
            self.wfile.write(json.dumps({"status": "cleared"}).encode())

        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, format, *args):
        _ = (format, args)
        # Tysta vanliga request-loggar, vi har egen utskrift
        pass


def main():
    port = 8765
    server = HTTPServer(("localhost", port), BlocketHandler)

    pr = port
    print(f"""
╔══════════════════════════════════════════════════════════╗
║           BLOCKET CAR TRACKER SERVER                     ║
╠══════════════════════════════════════════════════════════╣
║  Server körs på: http://localhost:{pr}                   ║
║  Kalkylator:     http://localhost:{pr}/                  ║
║  API endpoint:   http://localhost:{pr}/car               ║
╠══════════════════════════════════════════════════════════╣
║  Installera först Firefox-pluginet:                      ║
║  1. Öppna Firefox och gå till `about:debugging`          ║
║  2. Klicka på "This Firefox" i vänstermenyn              ║
║  3. Klicka "Load Temporary Add-on..."                    ║
║  4. Navigera till denna mapp och välj `manifest.json`    ║
║                                                          ║
╠══════════════════════════════════════════════════════════╣
║  Väntar på data från Firefox-extensionen...              ║
║  Tryck Ctrl+C för att avsluta                            ║
╚══════════════════════════════════════════════════════════╝
""")

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer avslutad.")
        server.shutdown()


if __name__ == "__main__":
    main()
