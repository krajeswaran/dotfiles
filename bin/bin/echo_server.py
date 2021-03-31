#!/usr/bin/env python3
# Reflects the requests from HTTP methods GET, POST, PUT, and DELETE

from http.server import HTTPServer, BaseHTTPRequestHandler
from optparse import OptionParser
import json
import sys


class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        request_path = self.path
        print("\n----- Request Start ----->\n")
        print("Request path:", request_path)
        print("Request headers:", self.headers)
        print("<----- Request End -----\n")
        self.send_response(200)
        self.end_headers()

    def do_POST(self):
        request_path = self.path
        print("\n----- Request Start ----->\n")
        print("Request path:", request_path)
        request_headers = self.headers
        content_length = request_headers.get('Content-Length')
        content_type = request_headers.get('Content-Type')
        length = int(content_length) if content_length else 0
        print("Content Length:", length)
        print("Request headers:", request_headers)

        if 'json' in content_type:
            parsed = json.loads(self.rfile.read(length))
            print("Request payload:", json.dumps(parsed, indent=2))
        else:
            print("Request payload:", self.rfile.read(length))

        print("<----- Request End -----\n")
        self.send_response(200)
        self.end_headers()

    do_PUT = do_POST
    do_DELETE = do_GET

def main():
    port = 8080 if not len(sys.argv) > 1 else int(sys.argv[1])
    print('Listening on localhost:%s' % port)
    server = HTTPServer(('', port), RequestHandler)
    server.serve_forever()

if __name__ == "__main__":
    main()
