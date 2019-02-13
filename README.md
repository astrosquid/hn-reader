# hn-reader

Have you ever wanted to read Hacker News but didn't want to open a new tab in your already-inundated browser?

Never fear, now you can goof off while reading the most important updates from the most self-important place on the internet.

## Running

    ruby -Ilib bin/hn_reader

## Testing

    rspec

## Usage
```bash
$ ruby -Ilib bin/hn_reader # fetches Hacker News
$ ruby -Ilib bin/hn_reader --belong # belong io
$ ruby -Ilib bin/hn_reader --pinboard # pinboard popular page
$ ruby -Ilib bin/hn_reader --github # github trending
$ ruby -Ilib bin/hn_reader --hyperlink # print hyperlinks in terminals (VTE-based terms only)
```
