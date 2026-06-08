A LOG.md to turn into NOTES.md

- Elixir/`mise` errors
- We're building a crawler for the Gemini Protocol and adjusting the take-home accordingly in real-time
- I want to be able to submit a URL to kick off a crawl (if not already seen) and a simple API to query the data
- We'll change work from task to page
- No need to simulate
- Our page table will be a table for page statistics (see schema)
- Before I forget: I want to avoid pounding the same host w/ request (a good operational constraint to work into the take-home)
- I want to collect the following:
  - full (absolute) URL
  - the header
  - the byte count
  - internal link count
  - external link count
- Another time
  - the redirect chain if there were one 
  - SSL/TLS info (at some point), 
- Switched over to Cursor for a full data-model... working through `robots.txt` considerations
- I will copy+paste a transcript from Cursor
- Adjusting `mix.gen.json` snippet manually...

```
mix phx.gen.json Probe Page pages \
  url:string \
  domain:string \
  status:integer \
  meta:text \
  size:integer \

mix phx.gen.json Probe Link links \
  source_page:references:pages \
  target_page:references:pages \
  label:string

mix phx.gen.json Probe Capsule capsules \
  domain:string \
  robots:text
```

- 2x responses when submitting a URL to crawl via API
- Using IEx and GUI DB client for development
- The above is data we want to query
- Oban will handle operational stuff
- Let's get things working E2E
- **Loop-back**: Arrange indexes when we focus more on controller
- The Phoenix Context should have a seed function, a crawl function, and a bots function?
- Let's start with a simple crawl confined to a domain
- 
