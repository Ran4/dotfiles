# Scraping websites som blockerar WebFetch

Vissa sidor (t.ex. blocket.se) blockerar WebFetch. Använd `crawl4ai` i stället
för att få ut renderad html som markdown

## Minimal uv inline-script

```python
# /// script
# requires-python = ">=3.11"
# dependencies = ["crawl4ai"]
# ///
import asyncio
from crawl4ai import AsyncWebCrawler, BrowserConfig, CrawlerRunConfig, CacheMode

async def main():
    cfg = CrawlerRunConfig(cache_mode=CacheMode.BYPASS, page_timeout=45000)
    async with AsyncWebCrawler(config=BrowserConfig(headless=True)) as c:
        r = await c.arun(url="<URL>", config=cfg)
        print(r.markdown)

asyncio.run(main())
```

## Blocket-specifikt

- Sök-URL: `https://www.blocket.se/bilar/sok?q=<term>&sort=price`
  (sort: `price` = lägst först, `date` = nyast först)
- Blocket renderar SSR — ingen JS-väntan eller cookie-vägg behövs
- Annonser i markdown-output har formatet:
  ```
  ## [](https://www.blocket.se/mobility/item/<id>)
  <titel>
  <år> ∙ <mil> mil ∙ <bränsle> ∙ <växel>
  <pris> kr
  <ort> ∙ <säljare>
  ```
- Enkel regex räcker för extraktion:
  `r"(\d{4}) ∙ ([\d\s]+) mil.*?\n([\d\s]+) kr"`
