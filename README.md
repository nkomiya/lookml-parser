# LookML parser

## Prerequisite
- Python
    - antlr4 tools

        ```bash
        pip install antlr4-tools
        ```

## Build

1. Build ANTLR4 grammar files

    ```bash
    (
        cd $(git rev-parse --show-toplevel)/src/grammar/ &&
        antlr4 -Dlanguage=JavaScript -visitor -o ../generated *.g4
    )
    ```
