Tu run cairo verifier follow this steps

build the latest version of the verifier to create sierra file

```
scarb build
```

install cairo-args-runner

```
cargo install cairo-args-runner
```

run the sierra file

```
cairo-args-runner target/dev/cairo_verifier.sierra < runner/resources/ready_input.json
```
