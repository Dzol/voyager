A LOG.md to turn into NOTES.md

- Elixir/`mise` errors
- We're building a crawler for the Gemini Protocol and adjusting the take-home accordingly in real-time
- I want to be able to submit a URL to kick off a crawl (if not already seen) and a simple API to query the data. In review, we do kick off a crawl, but it does not rule out those seen - I commented accordingly.
- We'll change work from task to page
- No need to simulate
- Our page table will be a table for page statistics (see schema). I've introduce a list of stats that would be interesting to talk through, not because of the stats themselves, but how they make the code more complex.
- Before I forget: I want to avoid pounding the same host w/ request (a good operational constraint to work into the take-home). Very much worth talking through.
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
- I will copy+paste a transcript from Cursor. I have since archived this and can not figure out how to retrieve it :/
- Adjusting `mix.gen.json` snippet manually; The end result:
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
- 2x responses when submitting a URL to crawl via API. A DX point on the JSON/HTTP API worth talking through.
- Using IEx and GUI DB client for development
- The above is data we want to query
- Oban will handle operational stuff (so don't have to work operational state, such as link.state = new | seen, into our data model)
- Let's get things working E2E
- **Loop-back**: Arrange indexes when we focus more on controller
- The Phoenix Context should have a seed function, a crawl function, and a bots function?
- Let's start with a simple crawl confined to a domain
- Just hit a single page via IEx and Oban
- Not a crawler till we're _looping_ so let's do that
- To keep it safe for experimenting let's include a depth limit
- Stepping away for a mo
- I was going to go with working on something E2E, from controller, to Oban/crawl...
- The trickier bit is all around Oban though; We prob won't get to dealing with `robots.txt` w/in three hours, but we can try addressing the host x host rate limit
