## Brakeman github action

### Usage

```yml
- name: Brakeman
  uses: devmasx/brakeman-lint-action@v1.0.0
  env:
    GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
```

### Custom report

```yml
- name: Install gems
  run: |
    gem install brakeman -v 4.5.0
- name: brakeman report
  run: |
    brakeman -f json > tmp/brakeman.json || exit 0
- name: Brakeman
  uses: devmasx/brakeman-lint-action@v1.0.0
  env:
    GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
    REPORT_PATH: tmp/brakeman.json
```
