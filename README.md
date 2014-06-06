# Woodchuck Filter

Filter your logs

## Usage

Single source and callback for filtering message. Enable
desired filters to modify the entry within the payload.

### Enable Filters

```json
{
  "fission": {
    "woodchuck_filter": {
      "enabled": [
        "status_tagger"
      ]
    }
  }
}
```

### Filters available

* `status_tagger` add status tag based on content (debug, error, etc.)