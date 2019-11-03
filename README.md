## Coverage check

A GitHub Action that check minimum coverage percentage!

### Usage

#### Lcov

```yml
- uses: devmasx/coverage-check-action@v1.1.0
  with:
    type: lcov
    result_path: coverage/example.lcov
    min_coverage: 90
    token: ${{secrets.GITHUB_TOKEN}}
```

#### [Simplecov](https://github.com/colszowka/simplecov)

```yml
- uses: devmasx/coverage-check-action@v1.1.0
  with:
    type: simplecov
    result_path: coverage/.last_run.json
    min_coverage: 90
    token: ${{secrets.GITHUB_TOKEN}}
```

## Screenshots

![Success](./screenshots/success.png)
![Fail](./screenshots/fail.png)
