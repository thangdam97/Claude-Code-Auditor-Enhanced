# Professional README Generator Prompt

When asked to create a README.md for GitHub, follow these STRICT guidelines:

## TONE & STYLE REQUIREMENTS

**FORBIDDEN:**
- ❌ Excessive emojis (max 2 total, only for major section headers)
- ❌ Marketing language ("amazing", "revolutionary", "game-changing")
- ❌ Hyperbole ("best ever", "incredible", "awesome")
- ❌ Buzzwords without technical substance
- ❌ Exclamation marks in headers
- ❌ All-caps emphasis (except acronyms)

**REQUIRED:**
- ✓ Technical, precise language
- ✓ Concrete examples over abstract claims
- ✓ Clear setup instructions BEFORE theory
- ✓ Numbered lists for procedures
- ✓ Code blocks with syntax highlighting
- ✓ Measured tone (like academic papers or technical docs)

---

## STRUCTURE TEMPLATE

```markdown
# Project Name

Brief 1-2 sentence description of what this does. Technical, not marketing.

## Quick Start

[Setup instructions FIRST - get them running in <5 minutes]

### Prerequisites
- List exact versions
- Be specific (not "Node.js" but "Node.js 18+")

### Installation
```bash
# Exact commands
npm install package-name
```

### Basic Usage
```language
// Minimal working example
const example = require('package');
```

## Features

- Feature 1: Technical description
- Feature 2: What it does, not why it's "amazing"
- Feature 3: Concrete capability

## Documentation

### Configuration
[Detailed config options]

### Examples
[Real-world usage examples]

### API Reference
[If applicable]

## Performance

[If relevant - with benchmarks, not claims]

| Metric | Value |
|--------|-------|
| Speed  | 100ms |
| Size   | 5KB   |

## Development

### Testing
```bash
npm test
```

### Contributing
Standard contribution guidelines

## License

[License type]
```

---

## SPECIFIC RULES

1. **Headers:** No emoji, no punctuation (except : for subheaders)
   - ✓ "## Installation"
   - ✗ "## 🚀 Installation!!"

2. **Claims:** Must be verifiable
   - ✓ "99.5% success rate (10 tests)"
   - ✗ "Super reliable!"

3. **Examples:** Real, executable code
   - ✓ Actual commands that work
   - ✗ Pseudocode or "just do X"

4. **Metrics:** Provide numbers
   - ✓ "75% cost reduction vs X"
   - ✗ "Much cheaper!"

5. **Comparisons:** Factual tables
   - ✓ Feature matrix with checkmarks
   - ✗ "Better than everything else"

6. **Language:** Technical precision
   - ✓ "Validates syntax before applying changes"
   - ✗ "Magically prevents bugs!"

---

## EXAMPLES

### BAD (LLM Default):
```markdown
# 🚀✨ AWESOME Code Auditor! 💎

This is an INCREDIBLE tool that will REVOLUTIONIZE your workflow! 
Say goodbye to bugs FOREVER! 🎉

## Features 🌟
- Amazing performance! ⚡
- Super easy to use! 👍
- The best solution available! 🏆
```

### GOOD (Professional):
```markdown
# Code Change Auditor Protocol

AI-assisted code review framework with structured risk classification 
and validation. Tested with 99.5% success rate across 10 edge cases.

## Installation

```bash
# Copy protocol file
cp .clauderc your-project/

# Verify deployment
cat your-project/.clauderc
```

## Features

- Type A/B/C risk classification
- Syntax validation before changes
- Diff-based approval workflow
- Model-agnostic (Claude, GPT, Gemini)
```

---

## PROMPT TEMPLATE

When creating README, use:

```
Create a professional, technical README.md for [PROJECT NAME].

Requirements:
- Maximum 2 emoji total (only for major sections)
- No marketing language or hyperbole
- Setup instructions before theory
- Concrete examples with real code
- Verifiable claims with evidence
- Technical precision over enthusiasm
- Measured academic tone

Structure:
1. Brief technical description (2 sentences max)
2. Quick Start with exact commands
3. Features (concrete capabilities)
4. Configuration/Usage
5. Performance data (if applicable)
6. Development/Testing
7. License

Style: Linux kernel documentation, not startup landing page.
```

---

## VALIDATION CHECKLIST

Before accepting a README, verify:

- [ ] Emoji count ≤ 2
- [ ] No exclamation marks in headers
- [ ] No words: "amazing", "awesome", "incredible", "revolutionary"
- [ ] All code examples are executable
- [ ] Claims have evidence (test results, benchmarks)
- [ ] Setup section comes first
- [ ] Language is technical, not marketing
- [ ] Tone is measured, not enthusiastic

If any fail, request revision with specific issues noted.
