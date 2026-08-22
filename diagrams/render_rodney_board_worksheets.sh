#!/usr/bin/env bash

set -euo pipefail

dot -Tjpg -o diagrams/RodneyBoardA-worksheet.jpg diagrams/RodneyBoardA-worksheet.dot
dot -Tjpg -o diagrams/RodneyBoardB-worksheet.jpg diagrams/RodneyBoardB-worksheet.dot
dot -Tjpg -o diagrams/RodneyBoardC-worksheet.jpg diagrams/RodneyBoardC-worksheet.dot
dot -Tjpg -o diagrams/RodneyWirewrapWorksheetStack.jpg diagrams/RodneyWirewrapWorksheetStack.dot
