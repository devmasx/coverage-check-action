## Coverage check

A GitHub Action that check minimum coverage percentage!

### Usage

#### [Simplecov](https://github.com/colszowka/simplecov)

```yml
- uses: devmasx/coverage-check-action@v1.0.1
  with:
    result_path: coverage/.last_run.json
    token: ${{secrets.GITHUB_TOKEN}}
    type: simplecov
    min_coverage: 90
```

#### Lcov

```yml
- uses: devmasx/coverage-check-action@v1.0.1
  with:
    result_path: coverage/example.lcov
    token: ${{secrets.GITHUB_TOKEN}}
    type: lcov
    min_coverage: 90
```

## Screenshots

![Success](./screenshots/success.png)
![Fail](./screenshots/fail.png)
