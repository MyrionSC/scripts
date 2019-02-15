#!/usr/bin/env python3

from bs4 import BeautifulSoup
import urllib.request
import urllib.parse
import urllib.error
import queue
import sys

def main():
    args = sys.argv
    if len(args) is not 3:
        print("Usage: " + args[0] + " SEARCHSTRING WEBURL")
        exit()

    searchString = args[1]
    webUrl = args[2]

    hostname = urllib.parse.urlparse(webUrl).hostname
    frontier = queue.Queue()  # put, get
    frontier.put(webUrl)
    closed = dict()

    consume(searchString, hostname, frontier, closed)


def consume(searchstring: str, hostname: str, frontier: queue.Queue, closed: dict):
    # get next url from frontier
    url = frontier.get()
    # or urllib.parse.urlparse(url).hostname is hostname
    while url in closed:  # keep going through frontier until finds url not in closed
        url = frontier.get()

    # add url to closed and search for substring
    closed[url] = 0

    # parse url
    try:
        with urllib.request.urlopen(url) as response:
            html = response.read()
        soup = BeautifulSoup(html, 'html.parser')
        closed[url] = soup.get_text().count(searchstring)
        print(url + ": " + str(closed[url]))

        for tag in soup.find_all('a'):
            link = urllib.parse.urljoin(url, tag.get('href'))
            hashIndex = link.rfind("#")  # remove hashmark from links
            if hashIndex is not -1:
                link = link[:hashIndex]
            frontier.put(link)
    except urllib.error.URLError as e:
        print(str(e))

    # keep going
    consume(searchstring, hostname, frontier, closed)


if __name__ == "__main__": main()
