---
name: todo
description: Create and maintain the user's to-do list in ~/work/autotodo.md from Gmail, Jira and Slack. Use when the user asks for their to-do list, to refresh their to-dos, or to add something to their to-dos.
---

Maintain the user's to-do list in `~/work/autotodo.md`. Create it if missing.

The file starts with YAML front matter that holds the time of the last refresh:

```markdown
---
last_refreshed: 2026-10-26 14:05
---

- Prepare feedback for the team retro
  - Tue 11:00, "come prepared to share your honest feedback"

- Review Alex's PR on the billing service
  - adds retries to the invoice export
  - https://github.com/example/billing/pull/123

- Answer Sam about the export thresholds ?
  - Slack DM, asks which cutoff to use

- PROJ-123: fix the usage dashboard
  - https://example.atlassian.net/browse/PROJ-123
```

Refresh:
1. Run `date '+%Y-%m-%d %H:%M'` and keep the result as the refresh time.
2. Read the file. The window start is `last_refreshed`, or 7 days before the
   refresh time if the file or the field is missing.
3. Collect what is new since the window start:
   - Gmail: search threads with `in:inbox after:<window start as epoch
     seconds>`, page size 50, following `nextPageToken`. Work from sender,
     subject and snippet; open a thread only when the snippet does not say
     what happened.
   - Jira: find the cloud ID with `getAccessibleAtlassianResources`, then
     search with `assignee = currentUser() AND statusCategory != Done AND
     updated >= "<window start>"`.
   - Slack: search with the window start as the `after` Unix timestamp, once
     with `<@USER_ID>` as a keyword for mentions and once with the filter
     `is:dm` for direct messages. Follow the cursor until the last page. Get
     the user's ID from their Slack profile.
4. Keep only what needs action from the user. Check the real state where a
   message alone cannot tell, for example a pull request with `gh pr view`.
   Real preparation work from a calendar invite counts; a pending invite
   itself never does.
5. Update the file by inserting lines only:
   - The user edits it too: they reorder, delete, rephrase, re-mark items and
     add their own notes. There is no backup, so keep every existing line as
     it is.
   - Once the file exists, use the Edit tool, never Write. The only existing
     line you may change is `last_refreshed`.
   - Add new items at the bottom. For news on an existing item, insert a
     detail bullet under it.
   - Never close, tick or remove an item unless the user says so.
6. Set `last_refreshed` to the refresh time from step 1.
7. Reply with the items added or changed, one line each.

Stay read-only in Gmail, Jira and Slack.

Format:
- One top-level bullet per item: a short headline of what to do.
- A blank line between items.
- At most one or two detail bullets per item, one level deep.
- Keep lines around 80 characters so the file reads in a split view; a longer
  line is fine when needed. Never wrap lines.
- Markers where useful: `?` open point, `⚠️` caveat, `✅` done.

Details:
- A detail says what the item is about, the concrete ask (ideally quoted),
  timing or a condition, or gives the link.
- Every PR, issue or ticket gets its full URL, each on its own detail line.
  Links do not count toward the one or two details.
- Leave out what the user already knows, what the link shows (size, reviews,
  approvals), status the list implies, background and reasons, and anything
  the headline already says.
