---
name: email-inbox
description: List the user's unread Gmail inbox as short spoken-style headlines and as action items ordered quickest first. Use when the user asks what is unread, what is in their inbox, what their email action items are, or for an email digest.
---

Summarize the user's unread Gmail inbox and turn it into action items.

Rules:
1. Search Gmail threads with the query `is:unread in:inbox`, page size 50. Follow `nextPageToken` until there are no more pages. Only unread threads in the inbox count; ignore unread mail outside the inbox.
2. Work from sender, subject and snippet. Open a thread with `get_thread` in `PLAIN_TEXT` format only when the snippet does not say what happened.
3. Collapse each thread to its latest state. A review request followed by a merge is "merged". Several updates to one calendar series are one change.
4. Check the real state where an email alone cannot tell:
   - GitHub pull requests: `gh pr view <number> --repo <owner/repo> --json state,reviewDecision,additions,deletions,changedFiles,reviewRequests` tells whether a review is still needed and how big it is.
   - Calendar invites: search the event in Google Calendar and read the user's own `responseStatus`. Only `needsAction` makes it an action item.
5. Open with one bold line: the number of unread threads and how many need action.
6. Then list numbered action items ordered quickest first: things done in seconds (answer an invite, clear FYI mail), then minutes (skim a post, prepare notes), then the big items (reviews, real work) last. Give each a rough time.
7. Each item names the thread, the person, and what to do, for example "Answer Alex's moved retrospective invite, now Tue 11:00-12:00". Write headlines in your own words, not the subject line.
8. Put all threads that need no action into one "clear these" item that names each one briefly (merged PRs by repository and number, closed issues, calendar updates already answered).
9. Stay read-only. Never mark read, archive, label, reply or RSVP unless the user asks in that message. Marking read means removing the `UNREAD` label from each thread.
10. When the reply is read aloud, give a few sentences of plain prose instead: action items first, each named, no Markdown.
