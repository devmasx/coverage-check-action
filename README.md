## Coverage check

A GitHub Action that check minimum coverage percentage!

### Usage

#### [Simplecov](https://github.com/colszowka/simplecov)

```yml
- uses: devmasx/coverage-check-action@v1.0.0
  with:
    result_path: coverage/.last_run.json
    token: ${{secrets.GITHUB_TOKEN}}
    type: simplecov
    min_coverage: 90
```

## Screenshots

![Success](./screenshots/success.png)
![Fail](./screenshots/fail.png)
