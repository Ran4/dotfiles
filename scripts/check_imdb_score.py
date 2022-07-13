"""
Retrieves the score for a certain IMDB url, and prints if it's at 6.0 or more,
without printing the actual rating if it is.

Great way to check if a movie is worth watching, without having imdb tell you
if it's a 6.1 or 8.9 (better have you decide that!).

Does not require any external libraries.
"""
import urllib.request
import re
import sys

# e.g. "https://www.imdb.com/title/tt10121392/"
try:
    IMDB_URL = sys.argv[1]
except IndexError:
    print(f"Usage: {sys.argv[0]} URL_TO_IMDB_MOVIE")
    exit(2)

with urllib.request.urlopen(IMDB_URL) as resp:
    html: str = resp.read().decode("utf-8")

# Because parsing html using regexp is definitely the right choice, eh? :)
title: str = re.search("<title>(.+?)</title>", html).group(1).replace(
    " - IMDb",
    "",
)
rating: str = re.search('worstRating.+"ratingValue":(.+?)}', html).group(1)

if float(rating) >= 6.0:
    print(f"{title} has rating at or above 6.0")

else:
    print(f"{title} has rating {rating} (below 6.0, should not see...)")
