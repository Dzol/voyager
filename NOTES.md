# Development Notes

I'll try to address the material in the take-home top down.
My time-box was three hours including NOTES.md.
I kept a running log in real time under LOG.md.

I adjusted the task to work on a crawler for the [Gemini Protocol](https://en.wikipedia.org/wiki/Gemini_(protocol)).
Gemini is far simpler than HTTP and HTML making a crawler tractable (and fun).
I got a crawl loop working via Oban in a Phoenix project.

### Data Model

The data model is a more complex, we have a page table, a link table, and essentially a "domain" table.
We could pick on or the other of `page` table and `link` table, i.e. just one of them, but having both means we can have a richer data-model for collecting page stats and index better.
In addition I'd consider introducing a ruleset table for `robots.txt`.

No foreign key constraints currently but links must point to pages.
The take-home mentions _scale_, honestly, I'd up the parallelism (number of workers for the crawl) and observe what happens.
That's on the "write" side.
On the "read" side, I'd be interested in retrieving lots of the data at once for visualisation, etc., so I'd consider an ETL and a different schema behind those controllers.
Now that I think about it... The data is web/net/graph shaped with hierarchy in URL path so burning that into a data-model with something like Postgres's `ltree` might make really good sense.
So, in this case, I think the read and write patterns differ enough to warrant a model for each.

### Oban

I really want to work through the Oban specifics here!
There's a lot here that is really interesting to try work through with Oban:

1. We don't want to pound the same host with too many requests at the same time.
2. We will need to fetch a `robots.txt` before hitting a site.

Would could queue a "robot" workers with higher priority than "page" workers.
If inserted together, i.e. the crawler fetches a URL for a domain that has not been visited, and we insert robot and page workers for both, then the robot worker will run before its corresponding pages.
There are other schemes we could consider.
I'd use the absolute URL of a page for uniqueness when scheduling a worker.

### OTP

Most Phoenix applications don't need a generic server.
The framework, Oban, and other tooling has us covered most of the time.
I can't think of where I'd use one here, but there might be a reason to use one, given it is not a regular Phoenix application.

I might consider a ETS table behind an `Agent` keep `robots.txt` rulesets or simply help to ask the question of if one has to be fetched in the first place.
I can't think of a caching scenario.
I can't see how quering for a page or robot rule would correlate with time so no sense in caching these.

On the fault-tolerance point: If we assume we don't roll our own OTP tree I would scope work into several workers so that each one has limited scope around what can fail.
That means workers have a simple responsibility, bound to one external I/O call, and then do a hand over by queuing more work.
A worker to crawl one page should insert links into the DB, and schedule another job to check robot rulesets, and schedule respective pages.

### System Design

I would avoid ALL "abstraction" till the system is already clean and tidy, i.e. once it is understood, bad abstractions are much worse than none at all.
