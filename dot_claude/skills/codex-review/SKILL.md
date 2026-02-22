---
name: codex-review
description: Cross-review code changes or plans using OpenAI Codex CLI. Use when the user wants an independent AI review of recent work.
user-invocable: true
allowed-tools: Bash, Read, Glob, Grep
---

# Codex Cross-Review

You are tasked with running an independent code review using OpenAI Codex CLI (`codex exec`).
This provides a second-opinion review from a different AI to catch blind spots.

## Arguments

- `$ARGUMENTS` may be: `code` (default if empty), `plan`, or a specific file path.

## Current Context

- Working directory: !`pwd`
- Git branch: !`git branch --show-current`
- Uncommitted changes: !`git diff --stat`

## Instructions

### Step 1: Determine Review Target

Based on `$ARGUMENTS`:
- If empty or `code`: Review uncommitted code changes (git diff)
- If `plan`: Review the most recently modified plan file in `~/.claude/plans/`
- If a file path: Review that specific file

### Step 2: Gather Content to Review

**For code review (`code`):**
1. Run `git diff` to get all unstaged changes
2. Also run `git diff --cached` to get staged changes
3. Combine both diffs. If no changes found, inform the user and stop.
4. Optionally gather recent commit context with `git log --oneline -5`

**For plan review (`plan`):**
1. Find the most recently modified `.md` file in `~/.claude/plans/` using:
   `ls -t ~/.claude/plans/*.md 2>/dev/null | head -1`
2. Read the plan file content using the Read tool
3. If no plan file found, inform the user and stop.

**For file review (specific path):**
1. Read the specified file using the Read tool
2. If file doesn't exist, inform the user and stop.

### Step 3: Run Codex Review

Create a temporary prompt file and run Codex:

```bash
PROMPT_FILE=$(mktemp /tmp/codex-review-XXXXXX.md)

# Write the review prompt to the temp file (content depends on review type)
cat > "$PROMPT_FILE" << 'PROMPT_END'
<review prompt content here - see templates below>
PROMPT_END

# Run Codex in read-only sandbox mode
codex exec - \
  --full-auto \
  --sandbox read-only \
  -o /tmp/codex-review-result.txt \
  < "$PROMPT_FILE"

# Read and display result
cat /tmp/codex-review-result.txt

# Cleanup
rm -f "$PROMPT_FILE" /tmp/codex-review-result.txt
```

### Step 4: Review Prompt Templates

**Code Review Prompt Template:**
```
You are an expert code reviewer performing an independent review.
Review the following git diff carefully and provide feedback.

Focus areas:
1. **Bugs & Logic Errors**: Incorrect logic, off-by-one errors, null/undefined handling, race conditions
2. **Security Vulnerabilities**: Injection attacks, XSS, CSRF, hardcoded secrets, insecure defaults
3. **Edge Cases**: Missing error handling, boundary conditions, empty/null inputs
4. **Code Quality**: Naming, readability, unnecessary complexity, DRY violations
5. **Performance**: Inefficient algorithms, unnecessary allocations, N+1 queries

Output format:
- List each issue with severity (CRITICAL / WARNING / INFO)
- Include the relevant file and line context
- Provide a brief suggested fix for each issue
- End with an overall assessment (APPROVE / REQUEST_CHANGES / COMMENT)

If no significant issues are found, state that the changes look good with a brief explanation of what was checked.

---
Git diff:
<diff content inserted here>
```

**Plan Review Prompt Template:**
```
You are an expert software architect reviewing an implementation plan.
Review the following plan and provide feedback.

Focus areas:
1. **Completeness**: Are all requirements addressed? Any missing steps?
2. **Correctness**: Is the technical approach sound? Any logical flaws?
3. **Risk Assessment**: What could go wrong? Are there edge cases not considered?
4. **Alternatives**: Are there simpler or better approaches not considered?
5. **Dependencies**: Are all dependencies identified? Any circular or missing dependencies?
6. **Testability**: Can the implementation be properly tested? Is the verification plan adequate?

Output format:
- List each concern with severity (CRITICAL / WARNING / SUGGESTION)
- Provide specific recommendations for each concern
- End with an overall assessment (APPROVE / NEEDS_REVISION / MAJOR_CONCERNS)

If the plan is solid, state that with a brief explanation of its strengths.

---
Plan:
<plan content inserted here>
```

### Step 5: Present Results

After Codex completes:
1. Read the output from `/tmp/codex-review-result.txt`
2. Present the review results to the user in a clear, formatted manner
3. Highlight any CRITICAL or WARNING items prominently
4. If reviewing a plan, suggest whether the user should approve, revise, or reject the plan based on Codex's feedback

### Error Handling

- If `codex` command is not found: Inform the user to install it (`npm install -g @openai/codex`)
- If Codex times out (>120 seconds): Inform the user and suggest running with a smaller diff
- If no changes to review: Inform the user there's nothing to review
- If Codex returns an error: Show the error output and suggest checking OPENAI_API_KEY
