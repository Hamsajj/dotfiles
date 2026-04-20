Create a draft GitHub pull request by following these phases in order.

---

## Phase 1: Gather context (run in parallel)

1. Run all of these at once:
   - `git branch --show-current` — current branch name
   - `git log origin/main..HEAD --oneline --no-merges` — commits on this branch
   - `git diff origin/main...HEAD --stat` — files changed
   - `git remote get-url origin` — to determine the GitHub org
   - Check for `.github/pull_request_template.md` and read it if present

2. Extract a Jira ticket ID from the branch name (e.g. `DYBA-807` from `DYBA-807_Migrate_To_V2`).
   If found, fetch the ticket using `mcp__atlassian__getJiraIssue` to get its title, description, and current status.

---

## Phase 2: Draft

Using the gathered context, compose:

**Title** — under 70 characters, prefixed with the Jira ticket ID when available:
`feat(DYBA-807): short description of the change`

**Body** — follow the repo's PR template structure exactly if one was found.
Otherwise use this structure:

```
#### PRs / Design Documents / Other documentation:
<!-- links to Jira ticket, design docs, etc. -->

#### What
<!-- what changed -->

#### Why
<!-- why this change is needed -->

#### How has this been tested?
<!-- how it was tested -->

#### Rollback/Recovery Plan (if needed)
<!-- how to recover if something goes wrong -->
```

**Writing style:**
- **Why** is the most important section — explain the problem or need that drove the change, with enough context for a reviewer who hasn't read the ticket.
- **What** should be brief — a high-level summary of what changed, not a per-file breakdown. No need to list every file or explain every individual change.
- for other sections, only include them if absolutely necessary. most of the time they add no real value
- Do not leave template placeholder text in the body.

**Closing footer** — append these lines at the very end of the body, in this order, when applicable:

1. If this PR fully resolves the Jira ticket (i.e. merging it will mark the ticket as done), add a closing reference linked to the ticket URL:
   `Closes [DYBA-807](https://epidemicsound.atlassian.net/browse/DYBA-807)`

2. If the repository belongs to the `epidemicsound` GitHub organisation (detectable from the remote URL), add the compliance comment on its own line:
   `<!-- id=i_confirm_compliance -->`

---

## Phase 3: Preview

Display the full drafted title and body to the user clearly.
Along with the preview, ask two things before proceeding:
1. Whether they approve the PR body or want changes.
2. Whether to append `🤖 Generated with [Claude Code](https://claude.ai/code)` as the absolute last line of the body, after all other footer lines including `<!-- id=i_confirm_compliance -->`.

Do not create the PR until they confirm.

---

## Phase 4: Push and create

Once the user approves:

1. Check whether the branch is pushed: `git status -sb`
   - If no upstream is set, push it: `git push -u origin <branch-name>`

2. Create the PR as a draft:
   ```
   gh pr create --draft --title "<title>" --body "<body>"
   ```

3. Return the PR URL to the user.
