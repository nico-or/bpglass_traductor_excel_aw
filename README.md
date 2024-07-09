# BPGlass Translator

Collection of Excel parsers and csv writers to allow fast translation between various file formats used inside the company.

The original porpouse was to allow the automatic translation of the AW files to planificacion lines (TSV data), tthat prevoiously was done manually.

This allowed for significant reductions in

- time expend copying and pasting data
- errors while typing or aplying the bussiness rules
- inconsistencies in formatting

After that, and thanks to the internal data representation, additional writers could be developed to allow for additional functionalities.

## How to use

### Prerequisites

1. Install the [Ruby programming language](https://www.ruby-lang.org/en/downloads/).
2. Install the [roo gem](https://github.com/roo-rb/roo)
3. copy this repository.
4. create an `Archivos AW` directory alongside the repository files.

### Instructions

1. Copy the _archivos AW_ to translate inside the directory `./Archivos AW`
2. Execute any of the available files (`planificacion.rb`, `carga_futura.rb`, `translate.rb`, `json.rb`) using the ruby interpreter.

   ```sh
   $ ruby planificacion.rb
   ```

3. Copy the content of the output `.txt` file to a spreadsheet software.

## TODO

- Add RDOC comments to modules and functions.
- Turn the module into a proper Ruby gem.
  - Make dependencies explicit.
  - Avoid copying test when downloading from github.
- Refactor Cristales and Separadores.
  - Decide between raising exceptions or returning default value when no match is found.
  - Maybe remove the YAML files in lib/data and write directly in module.
