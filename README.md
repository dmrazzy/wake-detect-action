# Wake Detect GitHub Action

![white](https://github.com/Ackee-Blockchain/wake-detect-action/assets/56036748/ec488c85-2f7f-4433-ae58-3d50698a47de)


This GitHub Action runs the Wake static analysis tool. It's configurable via several optional inputs and it outputs a SARIF file if specified.

## Usage

The action is used in a workflow file with the `uses` keyword. Here's an example of action with SARIF export:

```yaml
steps:
  - name: Run static analysis
    uses: Ackee-Blockchain/wake-detect-action@0.1.0
    with:
      export-sarif: true
    id: wake-detect

  - name: Upload SARIF
    uses: github/codeql-action/upload-sarif@v2
    with:
      sarif_file: ${{ steps.wake-detect.outputs.sarif }}
      checkout_path: ${{ github.workspace }}
```

## Inputs (optional)

- `working-directory`: The working directory for the action.
- `export-sarif`: If set, the action will export a SARIF file.
- `config-path`: Path to the configuration file relative to the working directory.
- `compile-allow-paths`: Paths that are allowed for the compiler.
- `compile-evm-version`: EVM version to compile for.
- `compile-ignore-paths`: Paths that the compiler should ignore.
- `compile-include-paths`: Paths that should be included in the compilation.
- `compile-optimizer-enabled`: Enable the optimizer during compilation.
- `compile-optimizer-runs`: Number of runs for the optimizer.
- `compile-remappings`: Remappings for the compiler.
- `compile-target-version`: Target version for the compiler.
- `compile-via-ir`: Compile via IR.
- `detect-min-impact`: Minimum impact level for detection.
- `detect-min-confidence`: Minimum confidence level for detection.
- `detect-paths`: Paths for detection.
- `detect-only`: Only detect vulnerabilites with these detectors.
- `detect-exclude`: Exclude these detectors.
- `detect-ignore-paths`: Paths to ignore during detection.
- `detect-exclude-paths`: Paths to exclude during detection.

For more information about the parameters, see the [Wake documentation](https://ackeeblockchain.com/wake/docs/latest/).

## Outputs

- `sarif`: Exported SARIF file path relative to the repository root.

## Exit codes

It returns zero (success) if there are no detections or if SARIF export is enabled. Otherwise, it returns non-zero exit code.

## Code scanning preview

When SARIF file is exported, GitHub provides UI for these detections.

<img width="854" alt="image" src="https://github.com/Ackee-Blockchain/wake-detect-action/assets/56036748/7d418569-604e-4746-90f3-b58e909c705b">

## Limitations

- Currently, the action only takes the latest version of Wake for the sake of the newest detectors.
